[![OmniPackage repositories badge](https://repositories.omnipackage.org/oleg/examples-c-makefile/examples-c-makefile.svg)](https://web.omnipackage.org/oleg/examples-c-makefile/install)

# C Makefile

The most basic program in C without dependencies besides libc.

## Multiple configs

It also demostrates how to build multiple variants of the same projects in one repository. The default config `.omnipackage/config.yml` provides the default build variant, and `.omnipackage/config2.yml` provides the same projects with different package name. In real world you might want to have "stable" and "dev" variants, where not only `package_name` is different but also compliation flags etc.

When creating a project on OmniPackage web you can specify the path to config, i.e. `.omnipackage/config2.yml`. This way you'll have different projects on OmniPackage web with different configs, but the same upstream repository.
