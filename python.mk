# Python

ver=2.7.10
py=Python-$(ver)

all: $(py)/python

install: $(PREFIX)/bin/python $(PREFIX)/bin/pip

$(py).tgz:
	curl -O https://www.python.org/ftp/python/$(ver)/$(py).tgz

$(py): $(py).tgz
	tar xzf $(py).tgz

$(py)/Makefile: $(py)
	cd $(py) && ./configure --prefix=$(PREFIX)

$(py)/python: $(py)/Makefile
	cd $(py) && make -j

$(PREFIX)/bin/python: $(py)/python
	cd $(py) && make install

get-pip.py:
	wget https://bootstrap.pypa.io/get-pip.py

$(PREFIX)/bin/pip: $(PREFIX)/bin/python get-pip.py
	$(PREFIX)/bin/python get-pip.py
