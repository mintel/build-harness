FAAS_MAGIC_DATE := 19700101
FAAS_BUILD_DIST:=$(CURDIR)/dist
FAAS_BUILD_PYTHON_VENV:=$(FAAS_BUILD_DIST)/.venv

$(FAAS_BUILD_DIST):
	mkdir -p $(FAAS_BUILD_DIST)


# - - - - - - - -
# PYTHON
# - - - - - - - -
$(FAAS_BUILD_PYTHON_VENV):
	$(WITH_PIPENV) pip install -r <(PIPENV_QUIET=1 pipenv --bare lock -r) --ignore-installed --target $(FAAS_BUILD_PYTHON_VENV)
	find -L . -path $(FAAS_BUILD_PYTHON_VENV) -prune -exec touch -d "$(FAAS_MAGIC_DATE)" {} +
	find -L $(FAAS_BUILD_PYTHON_VENV) -exec touch -d "$(FAAS_MAGIC_DATE)" {} +

faas/build/python/venv:
	@test -d $(FAAS_BUILD_PYTHON_VENV) && echo "Using cached dist venv. Please 'make faas/clean' before building if it has changed." || true
	@make $(FAAS_BUILD_PYTHON_VENV)
.PHONY: faas/build/python/venv

faas/build/python/zip:
	cd $(FAAS_BUILD_PYTHON_VENV) && zip $(FAAS_BUILD_DIST)/build.zip -rq *
	cd func && zip $(FAAS_BUILD_DIST)/build.zip -r *py
	touch -d "$(FAAS_MAGIC_DATE)" $(FAAS_BUILD_DIST)/build.zip
.PHONY: faas/build/python/zip

## Build python serverless function into a zip
faas/build/python: $(FAAS_BUILD_DIST) faas/build/python/venv faas/build/python/zip
.PHONY: faas/build/python


# - - - - - - - -
# CLEANUP
# - - - - - - - -
## Clean up faas artifacts.
faas/clean:
	rm -rf $(FAAS_BUILD_DIST)/build.zip
	test -d $(FAAS_BUILD_PYTHON_VENV) && rm -rf $(FAAS_BUILD_PYTHON_VENV) || true
.PHONY: faas/clean
