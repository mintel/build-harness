PYTEST = $(PIPENV_RUN) pytest

.PHONY: pytest/init
pytest/init: pipenv reports/

.PHONY: pytest
## Run Python tests with pytest
pytest: pytest/init
	$(PYTEST)

.PHONY: pytest/lf
pytest/lf: pytest/init
	$(PYTEST) --lf

.PHONY: pytest/pdb
pytest/pdb: pytest/init
	$(PYTEST) --pdb

.PHONY: pytest/mf/%
pytest/mf/%: pytest/init
	$(PYTEST) --maxfail=$*

.PHONY: pytest/k/%
pytest/k/%: pytest/init
	$(PYTEST) -k "$*"

.PHONY: pytest/m/%
pytest/m/%: pytest/init
	$(PYTEST) -m "$*"

####
# Targets calling specific custom flags we commonly see used.
####

.PHONY: pytest/pre-build
pytest/pre-build:
	@$(MAKE) pytest/m/"not postbuild"

.PHONY: pytest/post-build
pytest/post-build:
	@$(MAKE) pytest/m/"postbuild"

####
# Deprecated targets.
####

define pytest-deprecated
	@echo "WARNING: This target is deprecated. Please switch from '$(1)' to '$(2)'"
endef

.PHONY: pytest/test-lf
pytest/test-lf:
	$(call pytest-deprecated,$@,pytest/lf)

.PHONY: pytest/test
pytest/test: pytest/pre-build
	$(call pytest-deprecated,$@,pytest/pre-build)

.PHONY: pytest/test-post-build
pytest/test-post-build: pytest/post-build
	$(call pytest-deprecated,$@,pytest/post-build)
