# Go

Example of project written in Go. Some distros don't have Go in their main repositories, for those Go needs to be installed via `before_build_script`.

## Build

1. Generate GPG key
```
echo "GPG_KEY=$(omnipackage gpg generate --name 'Your Name' --email 'your@email' --format base64)" >> .env

```

2. Build & publish to local repository
```
omnipackage release .
```

3. Open `~/omnipackage-examples-repos/go/install.html` in browser. The repositories in this folder are fully functional on local machine.
