FAAS_MAGIC_DATE := 19700101
FAAS_BUILD_DIST:=$(CURDIR)/dist
FAAS_BUILD_VENV:=$(FAAS_BUILD_DIST)/.venv

$(FAAS_BUILD_DIST):
	mkdir -p $(FAAS_BUILD_DIST)

$(FAAS_BUILD_VENV):
	PIPENV_IGNORE_VIRTUALENVS=1 pipenv run pip install -r <(pipenv lock -r) --target $(FAAS_BUILD_VENV) --ignore-installed

faas/build/python: $(FAAS_BUILD_DIST) $(FAAS_BUILD_VENV)
	find -L . -path $(FAAS_BUILD_VENV) -prune -exec touch -d "$(FAAS_MAGIC_DATE)" {} +
	find -L $(FAAS_BUILD_VENV) -exec touch -d "$(FAAS_MAGIC_DATE)" {} +
	cd $(FAAS_BUILD_VENV) && zip $(FAAS_BUILD_DIST)/build.zip -rq *
	cd $(CURDIR)/func && zip $(FAAS_BUILD_DIST)/build.zip -r *py
	touch -d "$(FAAS_MAGIC_DATE)" $(FAAS_BUILD_DIST)/build.zip
.PHONY: faas/build/python

faas/clean:
	rm -rf $(FAAS_BUILD_DIST)/build.zip
	rm -rf $(FAAS_BUILD_VENV)
.PHONY: faas/clean
