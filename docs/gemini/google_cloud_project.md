## Getting Started with GOOGLE_CLOUD_PROJECT

<!-- Preserve links to login steps that now live in the login guide. -->
<a id="1-initial-setup"></a>
<a id="2-get-authentication-url"></a>
<a id="3-complete-authentication"></a>
<a id="4-start-using-gemini"></a>

Gemini is deprecated in InBox. This page is for existing users who need a Google Cloud project ID.
For login, use the [Gemini guide](./getting_started.md).

### Configure Google Cloud Project

1. In your host terminal, prepare the `work` profile's file without replacing its content:

   ```bash
   mkdir -p "$HOME/.inbox/gemini-work/.gemini"
   touch "$HOME/.inbox/gemini-work/.gemini/.env"
   ```

2. Open `.env` in your editor. Add or update this entry, keeping other entries:

   ```dotenv
   GOOGLE_CLOUD_PROJECT=your-project-id
   ```

   Replace `your-project-id` with your Google Cloud project ID.

3. Start the same profile:

   ```bash
   inbox gemini -p work -n
   ```

Host environment variables are not forwarded automatically. Set the value in the profile file above.
For the unnamed profile, replace `gemini-work` with `gemini` in the paths and omit `-p work`.

[Documentation index](../README.md) · [Manage profiles](../profiles.md)
