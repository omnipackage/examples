INSTALL_ROOT := install_root
CC := gcc
BINARY := helloworld

all:
	$(CC) -o $(BINARY) *.c

install:
	install -d -m755 $(INSTALL_ROOT)/usr/bin/
	install -m755 $(BINARY) $(INSTALL_ROOT)/usr/bin/

clean:
	rm -f $(BINARY)
