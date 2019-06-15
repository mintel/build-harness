FAAS_MAGIC_DATE := 19700101
FAAS_BUILD_DIST:=$(CURDIR)/dist
FAAS_BUILD_VENV:=$(FAAS_BUILD_DIST)/.venv

$(FAAS_BUILD_DIST):
	mkdir -p $(FAAS_BUILD_DIST)

$(FAAS_BUILD_VENV):
	$(WITH_PIPENV) pip install -r <(pipenv lock -r) --target $(FAAS_BUILD_VENV) --ignore-installed
	find -L . -path $(FAAS_BUILD_VENV) -prune -exec touch -d "$(FAAS_MAGIC_DATE)" {} +
	find -L $(FAAS_BUILD_VENV) -exec touch -d "$(FAAS_MAGIC_DATE)" {} +

## Package python serverless function into a zip
faas/build/python/zip:
	cd $(FAAS_BUILD_VENV) && zip $(FAAS_BUILD_DIST)/build.zip -rq *
	cd func && zip $(FAAS_BUILD_DIST)/build.zip -r *py
	touch -d "$(FAAS_MAGIC_DATE)" $(FAAS_BUILD_DIST)/build.zip
.PHONY: faas/build/python/zip

$(FAAS_BUILD_DIST)/build.zip: faas/build/python/zip

## Build python serverless function
faas/build/python: $(FAAS_BUILD_DIST) $(FAAS_BUILD_VENV) $(FAAS_BUILD_DIST)/build.zip
.PHONY: faas/build/python

faas/clean:
	rm -rf $(FAAS_BUILD_DIST)/build.zip
	rm -rf $(FAAS_BUILD_VENV)
.PHONY: faas/clean
