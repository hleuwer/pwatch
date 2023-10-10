PROGRAM=pwatch
SERVICE=pwatch.service
CONFIG=pwatch.conf
DOCS=pwatch.html
INSTALL_BIN=/usr/local/bin
INSTALL_SERVICE=/etc/systemd/system
INSTALL_CONFIG=/etc
INSTALL_DOCS=/var/www/html/docs

.PHONY: install uninstall start
install: 
	cp -f $(PROGRAM).lua $(PROGRAM)
	cp $(PROGRAM) $(INSTALL_BIN)
	cp $(SERVICE) $(INSTALL_SERVICE)
	cp $(CONFIG) $(INSTALL_CONFIG)
	mkdir -p $(INSTALL_DOCS)
	cp $(DOCS) $(INSTALL_DOCS)

uninstall:
	rm -f $(INSTALL_BIN)/$(PROGRAM)
	rm -f $(INSTALL_SERVICE)/$(SERVICE)
	rm -f $(INSTALL_CONFIG)/$(CONFIG)
	rm -f $(INSTALL_DOCS)/$(DOCS)
doc:
	markdown README.md > $(DOCS)

enable:
	systemctl enable $(SERVICE)

disable:
	systemctl disable $(SERVICE)

start:
	systemctl start $(SERVICE)

stop:
	systemctl stop $(SERVICE)

status:
	systemctl status $(SERVICE)
