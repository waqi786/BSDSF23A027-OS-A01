.PHONY: all clean multifile static dynamic install docs

all: multifile static dynamic

multifile:
	$(MAKE) -C src multifile

static:
	$(MAKE) -C lib static
	$(MAKE) -C src client_static

dynamic:
	$(MAKE) -C lib dynamic
	$(MAKE) -C src client_dynamic

install:
	sudo mkdir -p /usr/local/bin
	sudo cp -v bin/client_dynamic /usr/local/bin/client
	sudo mkdir -p /usr/local/share/man/man3
	sudo cp -v man/man3/*.3 /usr/local/share/man/man3/
	# update man DB
	sudo mandb || true

clean:
	$(MAKE) -C src clean
	$(MAKE) -C lib clean
	rm -f bin/*

docs:
	@echo "Man pages are in man/man3/"

