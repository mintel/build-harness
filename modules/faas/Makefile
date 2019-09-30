FAAS_MAGIC_DATE := 19700101
FAAS_BUILD_DIST:=$(CURDIR)/dist
FAAS_BUILD_PYTHON_VENV:=$(FAAS_BUILD_DIST)/.venv

$(FAAS_BUILD_DIST):
	mkdir -p $(FAAS_BUILD_DIST)


# - - - - - - - -
# PYTHON
# - - - - - - - -
$(FAAS_BUILD_PYTHON_VENV):
	$(WITH_PIPENV) pip install -r <(PIPENV_QUIET=1 pipenv --bare lock -r) --target $(FAAS_BUILD_VENV) --ignore-installed
	find -L . -path $(FAAS_BUILD_PYTHON_VENV) -prune -exec touch -d "$(FAAS_MAGIC_DATE)" {} +
	find -L $(FAAS_BUILD_PYTHON_VENV) -exec touch -d "$(FAAS_MAGIC_DATE)" {} +

fass/prepare/python:
	@test -f $(FAAS_BUILD_PYTHON_VENV) || echo "Using cached dist venv. Please `make fass/clean` before building if it has changed."
.PHONY: fass/prepare/python

## Package python serverless function into a zip
faas/build/python/zip:
	cd $(FAAS_BUILD_PYTHON_VENV) && zip $(FAAS_BUILD_DIST)/build.zip -rq *
	cd func && zip $(FAAS_BUILD_DIST)/build.zip -r *py
	touch -d "$(FAAS_MAGIC_DATE)" $(FAAS_BUILD_DIST)/build.zip
.PHONY: faas/build/python/zip

$(FAAS_BUILD_DIST)/build.zip: faas/build/python/zip

## Build python serverless function
faas/build/python: fass/prepare/python $(FAAS_BUILD_DIST) $(FAAS_BUILD_PYTHON_VENV) $(FAAS_BUILD_DIST)/build.zip
.PHONY: faas/build/python


# - - - - - - - -
# CLEANUP
# - - - - - - - -
faas/clean:
	rm -rf $(FAAS_BUILD_DIST)/build.zip
	rm -rf $(FAAS_BUILD_PYTHON_VENV)
.PHONY: faas/clean
