PYTHON=$(call which,python)

ifneq ($(GIT_TAG),)
FAAS_VERSION=$(GIT_TAG)
else
FAAS_VERSION=$(GIT_COMMIT_SHORT)
endif

TOML_SET_SCRIPT=$(BUILD_HARNESS_PATH)/modules/faas/toml_replace.py

FAAS_MAGIC_DATE := 19700101
FAAS_BUILD_DIST:=$(CURDIR)/dist
FAAS_BUILD_PYTHON_VENV:=$(FAAS_BUILD_DIST)/.venv

$(FAAS_BUILD_DIST):
	mkdir -p $(FAAS_BUILD_DIST)

# - - - - - - - -
# PYTHON
# - - - - - - - -
$(FAAS_BUILD_PYTHON_VENV):
	$(PIPENV_RUN) pip install -r <(PIPENV_QUIET=1 pipenv --bare lock -r) --ignore-installed --target $(FAAS_BUILD_PYTHON_VENV)
	find -L . -path $(FAAS_BUILD_PYTHON_VENV) -prune -exec touch -d "$(FAAS_MAGIC_DATE)" {} +
	find -L $(FAAS_BUILD_PYTHON_VENV) -exec touch -d "$(FAAS_MAGIC_DATE)" {} +

.PHONY: faas/build/pyproject-toml
faas/build/pyproject-toml: $(FAAS_BUILD_DIST)
	test -f pyproject.toml && cp pyproject.toml $(FAAS_BUILD_DIST) || echo -e "[project]\nversion=\"foo\"" > $(FAAS_BUILD_DIST)/pyproject.toml
	@$(PYTHON) $(TOML_SET_SCRIPT) $(FAAS_BUILD_DIST)/pyproject.toml $(FAAS_VERSION)

.PHONY: faas/build/python/venv
faas/build/python/venv:
	@test -d $(FAAS_BUILD_PYTHON_VENV) && echo "Using cached dist venv. Please 'make faas/clean' before building if it has changed." || true
	@make $(FAAS_BUILD_PYTHON_VENV)

.PHONY: faas/build/python/zip
faas/build/python/zip:
	cd $(FAAS_BUILD_PYTHON_VENV) && zip $(FAAS_BUILD_DIST)/build.zip -rq *
	cd func && zip $(FAAS_BUILD_DIST)/build.zip -r *py
	cd $(FAAS_BUILD_DIST) && (zip build.zip pyproject.toml || true)
	touch -d "$(FAAS_MAGIC_DATE)" $(FAAS_BUILD_DIST)/build.zip

.PHONY: faas/build/python
## Build python serverless function into a zip
faas/build/python: $(FAAS_BUILD_DIST) faas/build/python/venv faas/build/pyproject-toml faas/build/python/zip

.PHONY: faas/buildif/python
## Build python serverless function if it doesn't exist yet
faas/buildif/python:
	test -f $(FAAS_BUILD_DIST)/build.zip || $(MAKE) faas/build/python

# - - - - - - - -
# CLEANUP
# - - - - - - - -
.PHONY: faas/clean
## Clean up faas artifacts.
faas/clean:
	rm -rf $(FAAS_BUILD_DIST)/build.zip
	rm -f $(FAAS_BUILD_DIST)/pyproject.toml
	test -d $(FAAS_BUILD_PYTHON_VENV) && rm -rf $(FAAS_BUILD_PYTHON_VENV) || true
