YARN := $(shell which yarn 2>/dev/null)

FRONTEND_DIR?=$(CURDIR)
FRONTEND_DIR_REL:=$(shell echo "${FRONTEND_DIR}" | sed "s|${CURDIR}||" | sed "s|^/||")

.PHONY: yarn/debug
yarn/debug:
	@echo "CURDIR=$(CURDIR)"
	@echo "FRONTEND_DIR=$(FRONTEND_DIR)"
	@echo "FRONTEND_DIR_REL=$(FRONTEND_DIR_REL)"

node_modules: $(YARN) package.json yarn.lock ; @$(MAKE) yarn/install yarn/bootstrap

.PHONY: yarn/%
yarn/%: $(YARN) ; $(call assert-set,YARN) && yarn $*

.PHONY: yarn/init
yarn/init: node_modules

.PHONY: yarn/install
yarn/install: $(YARN) package.json yarn.lock ; set -ex && yarn --pure-lockfile --no-progress
	$(call assert-set,YARN)

.PHONY: yarn/build/%
yarn/build/%: yarn/init
	set -ex && \
		( \
			if [ ! -z "$(FRONTEND_DIR_REL)" ]; then cd "$(FRONTEND_DIR_REL)"; fi \
			&& cd $* \
			&& yarn run build \
		)

.PHONY: yarn/clean
yarn/clean: ; rm -rf node_modules
