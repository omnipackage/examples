INSTALL_ROOT := install_root
CC := gcc
BINARY := omnipackage_example_c_with_secrets

all:
	$(CC) -D'TOP_SECRET_KEY="${TOP_SECRET_KEY}"' -o $(BINARY) *.c

install:
	install -d -m755 $(INSTALL_ROOT)/usr/bin/
	install -m755 $(BINARY) $(INSTALL_ROOT)/usr/bin/

clean:
	rm -f $(BINARY)
