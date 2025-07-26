[![OmniPackage repositories badge](https://repositories.omnipackage.org/oleg/examples-c-with-secrets/examples-c-with-secrets.svg)](https://web.omnipackage.org/oleg/examples-c-with-secrets/install)

# C Makefile with secrets

The most basic program in C with secrets feature.

## Build

```
omnipackage build -s TOP_SECRET_KEY="12345" .
```
Secrets passed via `-s` or `--secret` option will be excluded from logs and passed as ENV variables.
