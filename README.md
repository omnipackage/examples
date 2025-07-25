# OmniPackage examples

A collection of "hello world" projects in different languages to demonstrate how to package them.

## Build locally

You need to have [omnipackage-agent](https://docs.omnipackage.org/getting_started/#installing-omnipackage-agent) installed.

Run `omnipackage build $PATH_TO_PROJECT`, for example `omnipackage build c_makefile` from the root of this repo.

Or `cd` into particular project folder and run `omnipackage build .` from there.

When finished you'll see a list of packages which can be installed on target distros. Note that these packages are unsigned and you'll get signature verification or similar error when installing. This is because signing is done on OmniPackage web side. Agent is responsible for building, while OmniPackage web does signing and publishing.

You can build only for specific distro, change build directory and other config options via command line or config file. Refer to `omnipackage build --help`.

## Real-world applications

Beyond these simple examples check out more comples applications that use OmniPackage:

- Qt/C++https://web.omnipackage.org/oleg/mpz

## More at [docs.omnipackage.org](https://docs.omnipackage.org/)
