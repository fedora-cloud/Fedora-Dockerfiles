all:
	@echo "usage: make pull"

UPSTREAM = https://raw.githubusercontent.com/cockpit-project/cockpit/master
WGET = wget -q

pull:
	$(WGET) $(UPSTREAM)/tools/Dockerfile
	$(WGET) $(UPSTREAM)/tools/cockpit-preview.repo
	$(WGET) $(UPSTREAM)/tools/atomic-run
	$(WGET) $(UPSTREAM)/tools/atomic-install
	$(WGET) $(UPSTREAM)/tools/atomic-uninstall
