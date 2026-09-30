## Getting Started with GOOGLE_CLOUD_PROJECT

### 1. Initial Setup

```bash
inbox gemini
```

Follow the prompts: select a theme and choose "Login with Google".

### 2. Get Authentication URL

```bash
inbox gemini
```

Copy the URL displayed in the terminal and open it in your browser.

### 3. Complete Authentication

* Log in with your Google account and grant the necessary permissions.
* Copy the verification code shown in the browser and paste it into your terminal.

### 4. Start Using Gemini

```bash
inbox gemini
```

### Configure Google Cloud Project

For the unnamed profile used by `inbox gemini`, prepare the configuration file without replacing existing content:

```bash
mkdir -p "$HOME/.inbox/gemini/.gemini"
touch "$HOME/.inbox/gemini/.gemini/.env"
```

Open that `.env` file in your editor and add or update only the following entry, preserving all other entries:

```dotenv
GOOGLE_CLOUD_PROJECT=your-project-id
```

For a named profile such as `work`, edit `$HOME/.inbox/gemini-work/.gemini/.env` instead and launch with `inbox gemini -p work`. Avoid `inbox profile gemini` when locating the unnamed profile: if a default profile name is configured, that command uses it even when the default agent is different.


[Documentation index](../README.md) · [Manage profiles](../profiles.md)
