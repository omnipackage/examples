# C Makefile

The most basic program in C without dependencies besides libc.

## Build

1. Generate GPG key
```
echo "GPG_KEY=$(omnipackage gpg generate --name 'test' --email 'test@test' --format base64)" >> .env

```

2. Build & publish to local repository
```
omnipackage release .
```

3. Open `/tmp/omnipackage-repos/install.html` in browser. The repositories in this folder are fully functional on local machine.

## Multiple configs

This project also demonstrates how to build multiple variants of the same projects in one repository. The default config `.omnipackage/config.yml` provides the default build variant, and `.omnipackage/config2.yml` provides the same projects with different package name. In real world you might want to have "stable" and "dev" variants, where not only `package_name` is different but also compilation flags etc.

To build with another config:
```
omnipackage release . --config-path .omnipackage/config2.yml
```
