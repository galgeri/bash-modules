.PHONY: install uninstall
.DEFAULT_GOAL := help

MAKEPATH := $(abspath $(lastword $(MAKEFILE_LIST)))
PWD := $(dir $(MAKEPATH))
USER_ID=$(shell id -u)
GROUP_ID=$(shell id -g)

# Configure Makefile to install bash-loader
BASHRC := $(HOME)/.bashrc
MODULES_DIR ?= modules
LOADER_LINE := source $(HOME)/.bash-modules/bash-modules.sh

help: ## * Show help (Default task)
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

install: ## Include bash-loader in ~/.bashrc
	@mkdir -p "$(MODULES_DIR)/aliases.d" "$(MODULES_DIR)/helpers.d" "$(MODULES_DIR)/bin"
	@echo "Installing bash module loader to $(BASHRC)..."
	@if [ "$(PWD)" != "$$HOME/.bash-modules/" ]; then \
		echo "❌ This project must be located at $$HOME/.bash-modules"; \
		echo "   Current path: $(PWD)"; \
		echo "   Please move it and try again."; \
		exit 1; \
	fi
	@if ! grep -Fxq "$(LOADER_LINE)" "$(BASHRC)"; then \
		echo >> "$(BASHRC)"; \
		echo "$(LOADER_LINE)" >> "$(BASHRC)"; \
		echo "✅ Loader added to $(BASHRC)."; \
	else \
		echo "ℹ️  Loader already present in $(BASHRC)."; \
	fi

init-modules-repo: ## Initialize a new git repo in modules/, set remote origin
	@if [ -d "$(MODULES_DIR)/.git" ]; then \
		echo "❌ Git repository already exists in modules/."; \
		exit 1; \
	fi
	@mkdir -p "$(MODULES_DIR)"
	@cd "$(MODULES_DIR)" && git init
	@cd "$(MODULES_DIR)" && \
		read -p "Remote git repository URL: " REMOTE_URL; \
		git remote add origin "$$REMOTE_URL"
	@echo "✅ Initialized git repository in $(MODULES_DIR) and linked to remote."

clone-modules-repo: ## Clone an existing modules repo into modules/
	@read -p "Remote git repository URL: " REMOTE_URL; \
	rm -rf "$(MODULES_DIR)"; \
	git clone "$$REMOTE_URL" "$(MODULES_DIR)"
	@echo "✅ Cloned modules repository into $(MODULES_DIR)"
