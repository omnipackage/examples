# Python

Example project in Python. Some distros have outdated versions of Python, for those Python is vendored.

## Build

1. Generate GPG key
```
echo "GPG_KEY=$(omnipackage gpg generate --name 'Your Name' --email 'your@email' --format base64)" >> .env

```

2. Build & publish to local repository
```
omnipackage release .
```

3. Open `~/omnipackage-examples-repos/python/install.html` in browser. The repositories in this folder are fully functional on local machine.
