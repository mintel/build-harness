YARN := $(shell which yarn 2>/dev/null)

export YARN_DIR?=frontend

## Build frontend files using yarn
yarn/build: $(YARN)
	$(call assert-set,YARN)
	set -ex \
		&& ( \
			cd $(YARN_DIR) \
			&& $(YARN) --pure-lockfile --no-progress \
			&& $(YARN) run build:prod \
			&& $(YARN) autoclean \
		)
.PHONY: yarn/lint

## Check frontend files using yarn
yarn/lint: $(YARN)
	$(call assert-set,YARN)
	cd $(YARN_DIR) && $(YARN) lint
.PHONY: yarn/lint

## Fix frontend files using yarn
yarn/fmt: $(YARN)
	$(call assert-set,YARN)
	cd $(YARN_DIR) && $(YARN) fmt:js
.PHONY: yarn/fmt
