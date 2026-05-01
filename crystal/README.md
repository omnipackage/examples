# Crystal

Example of project written in Crystal. Some distros don't have Crystal in their main repositories, for those Crystal needs to be installed via `before_build_script`.

## Build

1. Generate GPG key
```
echo "GPG_KEY=$(omnipackage gpg generate --name 'Your Name' --email 'your@email' --format base64)" >> .env

```

2. Build & publish to local repository
```
omnipackage release .
```

3. Open `/tmp/omnipackage-repos/install.html` in browser. The repositories in this folder are fully functional on local machine.
