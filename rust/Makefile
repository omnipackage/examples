INSTALL_ROOT := install_root
CARGO := cargo
BINARY := hellorust

all:
	$(CARGO) build --release

install:
	mkdir -p $(INSTALL_ROOT)/usr/bin/
	cp -p target/release/rust $(INSTALL_ROOT)/usr/bin/$(BINARY)

clean:
	$(CARGO) clean
