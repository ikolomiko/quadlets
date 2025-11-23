
PREFIX ?= /usr/local
DESTDIR ?=
BINDIR := $(DESTDIR)$(PREFIX)/bin
SHAREDIR := $(DESTDIR)$(PREFIX)/share/quadlets
BASH_COMPLETION_DIR := $(DESTDIR)$(PREFIX)/share/bash-completion/completions
ZSH_COMPLETION_DIR := $(DESTDIR)$(PREFIX)/share/zsh/site-functions

.PHONY: help install remove
.DEFAULT_GOAL := help

help:
	@echo "Available targets:"
	@echo "  install    Install qm and quadlet files to $(PREFIX) (use PREFIX=... or DESTDIR=... for staging)"
	@echo "  remove     Remove installed files from $(PREFIX)" 
	@echo "Variables:"
	@echo "  PREFIX     Installation prefix (default: /usr/local)"
	@echo "  DESTDIR    Staging directory prepended to PREFIX for packaging"
	@echo "Examples:"
	@echo "  make install               # install to /usr/local"
	@echo "  make PREFIX=/opt install   # install to /opt"
	@echo "  make DESTDIR=/tmp/stage install  # install into staging dir"


FOLDERS := \
	headscale \
	ikooskar-cloudauth \
	nextcloud \
	open-webui \
	overleaf \
	rustdesk \
	stalwart \
	vaultwarden

install:
	@echo "Installing qm to $(BINDIR) and other files to $(SHAREDIR)"
	@install -d "$(BINDIR)" "$(SHAREDIR)" "$(BASH_COMPLETION_DIR)" "$(ZSH_COMPLETION_DIR)"
	@install -m 755 qm "$(SHAREDIR)/qm"
	@ln -sfn "$(SHAREDIR)/qm" "$(BINDIR)/qm"
	@install -m 644 contrib/completions/qm.bash "$(BASH_COMPLETION_DIR)/qm"
	@install -m 644 contrib/completions/_qm "$(ZSH_COMPLETION_DIR)/_qm"
	for d in $(FOLDERS); do \
		if [ -d "$$d" ]; then \
			find "$$d" -type f -print0 | xargs -0 -n1 sh -c 'for f; do dest=$${f#./}; install -D -m 644 "$$f" "$(SHAREDIR)/$$dest"; done' _; \
		fi; \
	done

remove:
	@echo "Removing qm from $(BINDIR) and $(SHAREDIR)"
	@rm -f "$(BINDIR)/qm"
	@rm -rf "$(SHAREDIR)"
	@rm -f "$(BASH_COMPLETION_DIR)/qm"
	@rm -f "$(ZSH_COMPLETION_DIR)/_qm"

