.PHONY: help install-rootless install-rootful

# Default action: print available targets
.DEFAULT_GOAL := help

# Define default values
XDG_CONFIG_HOME ?= $(HOME)/.config

help:
	@echo "Available targets:"
	@echo "  install-rootless      Create symlinks for rootless quadlet installation"
	@echo "  uninstall-rootless    Remove symlinks for rootless quadlet installation"
	@echo "  install-rootful       Create symlinks for rootful quadlet installation "
	@echo "  uninstall-rootful     Remove symlinks for rootful quadlet installation "

install-rootless:
	@\
	echo "Installing rootless quadlets for all directories..."; \
	mkdir -p "$(XDG_CONFIG_HOME)/containers/systemd/"; \
	for d in */; do \
		d="$${d%/}"; \
		if [ -d "$$d" ]; then \
			echo "Creating symlink for $$d..."; \
			ln -sf "$(PWD)/$$d" "$(XDG_CONFIG_HOME)/containers/systemd/"; \
		fi \
	done; \
	systemctl --user daemon-reload;


uninstall-rootless:
	@\
	echo "Uninstalling rootless quadlets for all directories..."; \
	for d in */; do \
		d="$${d%/}"; \
		if [ -d "$$d" ]; then \
			echo "Removing symlink for $$d..."; \
			rm -f "$(XDG_CONFIG_HOME)/containers/systemd/$$d"; \
		fi \
	done; \
	systemctl --user daemon-reload;

install-rootful:
	@\
	echo "Installing rootful quadlets for all directories..."; \
	sudo mkdir -p /etc/containers/systemd/; \
	for d in */; do \
		d="$${d%/}"; \
		if [ -d "$$d" ]; then \
			echo "Creating symlink for $$d..."; \
			sudo ln -sf "$(PWD)/$$d" /etc/containers/systemd/; \
		fi \
	done; \
	sudo systemctl daemon-reload;

uninstall-rootful:
	@\
	echo "Uninstalling rootful quadlets for all directories..."; \
	for d in */; do \
		d="$${d%/}"; \
		if [ -d "$$d" ]; then \
			echo "Removing symlink for $$d..."; \
			sudo rm -f "/etc/containers/systemd/$$d"; \
		fi \
	done; \
	sudo systemctl daemon-reload;

