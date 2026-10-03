const { test } = require('node:test');
const assert = require('node:assert/strict');
const net = require('node:net');
const { spawn } = require('node:child_process');
const { once } = require('node:events');
const path = require('node:path');
const signInWithChatGPT = process.argv[2] || path.join(__dirname, '../boxes/codex/sign-in-with-chatgpt.cjs');
const delay = ms => new Promise(resolve => setTimeout(resolve, ms));

function start(code = 'setInterval(() => {}, 1000)') {
  const child = spawn(process.execPath, [signInWithChatGPT, process.execPath, '-e', code], { stdio: ['ignore', 'pipe', 'pipe'] });
  child.errors = '';
  child.stderr.on('data', data => child.errors += data);
  child.done = once(child, 'exit');
  return child;
}
async function ready(child) {
  for (let i = 0; i < 100; i++) {
    assert.equal(child.exitCode, null, child.errors);
    const connected = await new Promise(resolve => {
      const socket = net.connect(61455, '127.0.0.1');
      socket.on('error', () => resolve(false));
      socket.on('connect', () => { socket.destroy(); resolve(true); });
    });
    if (connected) return;
    await delay(20);
  }
  throw new Error('relay did not listen');
}
function exchange(payload) {
  return new Promise((resolve, reject) => {
    const socket = net.connect(61455, '127.0.0.1');
    const chunks = [];
    socket.on('error', reject);
    socket.on('connect', () => socket.end(payload));
    socket.on('data', data => chunks.push(data));
    socket.on('end', () => resolve(Buffer.concat(chunks)));
  });
}

test('relay preserves bytes and half-close, recovers from refused upstream, and exits cleanly', { timeout: 15000 }, async t => {
  const child = start();
  t.after(() => { if (child.exitCode === null) child.kill('SIGKILL'); });
  await ready(child);
  // Codex has not opened its callback listener yet; the relay must survive.
  await exchange(Buffer.from('no backend')).catch(() => {});
  assert.equal(child.exitCode, null);
  const backend = net.createServer({ allowHalfOpen: true }, socket => {
    const chunks = [];
    socket.on('error', () => {});
    socket.on('data', data => chunks.push(data));
    socket.on('end', () => socket.end(Buffer.concat(chunks)));
  });
  backend.listen(1455, '127.0.0.1');
  await once(backend, 'listening');
  t.after(() => backend.close());
  const request = Buffer.from('GET /auth/callback?code=TEST&state=TEST HTTP/1.1\r\nHost: 127.0.0.1:1455\r\n\r\n');
  const big = Buffer.alloc(256 * 1024, 0xab);
  await Promise.all([request, big, request].map(async payload => assert.deepEqual(await exchange(payload), payload)));
  const occupied = start();
  assert.equal((await occupied.done)[0], 1);
  assert.match(occupied.errors, /EADDRINUSE/);
  child.kill('SIGTERM');
  assert.equal((await child.done)[0], 143);
  const exiting = start('process.exit(37)');
  assert.equal((await exiting.done)[0], 37);
});
