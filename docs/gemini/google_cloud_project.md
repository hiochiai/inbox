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

You can set your project ID for the default profile with this command:

```bash
cat << EOF >$(inbox profile gemini)/.gemini/.env
GOOGLE_CLOUD_PROJECT=your-project-id
EOF
```