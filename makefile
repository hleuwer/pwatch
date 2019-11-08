PROGRAM=pwatch
SERVICE=pwatch.service
CONFIG=pwatch.conf
INSTALL_BIN=/usr/local/bin
INSTALL_SERVICE=/etc/systemd/system
INSTALL_CONFIG=/etc

.PHONY: install uninstall start
install:
	cp $(PROGRAM) $(INSTALL_BIN)
	cp $(SERVICE) $(INSTALL_SERVICE)
	cp $(CONFIG) $(INSTALL_CONFIG)

uninstall:
	rm -f $(INSTALL_BIN)/$(PROGRAM)
	rm -f $(INSTALL_SERVICE)/$(SERVICE)
	rm -f $(INSTALL_CONFIG)/$(CONFIG)

start:
	systemctl start $(SERVICE)

stop:
	systemctl stop $(SERVICE)

status:
	systemctl status $(SERVICE)
