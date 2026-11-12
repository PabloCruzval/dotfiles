# VS Code and system keyring

If VS Code fails to sync your account, it usually can't reach the system keyring. Set the password store explicitly in `~/.vscode/argv.json`:

```json
{
    "enable-crash-reporter": true,
    "password-store": "gnome-libsecret"
}
```
