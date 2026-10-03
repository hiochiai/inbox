// Fixed TCP relay for browser OAuth callbacks. No HTTP parsing or traffic logs.
const net = require('node:net');
const { spawn } = require('node:child_process');
const { constants } = require('node:os');

const sockets = new Set();
let child;
let stopping = false;

const server = net.createServer({ allowHalfOpen: true }, (client) => {
  const upstream = net.createConnection({
    host: '127.0.0.1', port: 1455, allowHalfOpen: true,
  });
  const destroyPair = () => {
    client.destroy();
    upstream.destroy();
  };
  for (const socket of [client, upstream]) {
    sockets.add(socket);
    socket.on('error', destroyPair);
    socket.on('close', () => sockets.delete(socket));
    socket.setTimeout(120_000, destroyPair);
  }
  // pipe handles backpressure and propagates FIN after buffered writes finish.
  client.pipe(upstream);
  upstream.pipe(client);
});

function closeRelay() {
  server.close();
  for (const socket of sockets) socket.destroy();
}

function stop(signal) {
  if (stopping) return;
  stopping = true;
  closeRelay();
  if (child) {
    child.kill(signal);
    setTimeout(() => child.kill('SIGKILL'), 5000).unref();
  } else {
    process.exitCode = 128 + constants.signals[signal];
  }
}

for (const signal of ['SIGINT', 'SIGTERM', 'SIGHUP']) {
  process.on(signal, () => stop(signal));
}

server.on('error', (error) => {
  console.error(`InBox callback relay failed: ${error.code}`);
  stop('SIGTERM');
  process.exitCode = 1;
});

// Start Codex only after the relay has successfully bound its port.
// 61455 is in IANA's Dynamic/Private range (49152–65535).
server.listen(61455, '0.0.0.0', () => {
  if (stopping) return;
  const [command, ...args] = process.argv.slice(2);
  child = spawn(command, args, { stdio: 'inherit' });
  child.on('error', (error) => {
    console.error(`InBox could not start Codex: ${error.code}`);
    process.exitCode = 1;
    closeRelay();
  });
  child.on('exit', (code, signal) => {
    process.exitCode = process.exitCode || (code ?? (128 + constants.signals[signal]));
    closeRelay();
  });
});
