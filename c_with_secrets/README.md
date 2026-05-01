# C Makefile with secrets

The most basic program in C with secrets feature.

## Build

1. Generate GPG key
```
echo "GPG_KEY=$(omnipackage gpg generate --name 'Your Name' --email 'your@email' --format base64)" >> .env

```

2. Set TOP_SECRET_KEY
```
echo "TOP_SECRET_KEY='Hi there, this is secret'" >> .env
```

3. Build & publish to local repository
```
omnipackage release .
```

4. Open `/tmp/omnipackage-repos/install.html` in browser. The repositories in this folder are fully functional on local machine.
