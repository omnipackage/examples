INSTALL_ROOT := install_root
CC := gcc
BINARY := helloworld

all:
	$(CC) -o $(BINARY) *.c

install:
	mkdir -p $(INSTALL_ROOT)/usr/bin/
	cp -p $(BINARY) $(INSTALL_ROOT)/usr/bin/

clean:
	rm -f $(BINARY)
