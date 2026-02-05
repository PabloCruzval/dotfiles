# Vs Code OS Keyring

You may be having trouble with VS Code when syncing your account. To fix it, you need to add the following setting in your `~/.vscode/argv.json`:

```json
{
    "enable-crash-reporter": true,
    "password-store": "gnome-libsecret"
}
```