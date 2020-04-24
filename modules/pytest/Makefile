pytest: pytest/test
.PHONY: pytest

pytest/test: pipenv reports/
	$(PIPENV_RUN) pytest -m "not postbuild"
.PHONY: pytest/test

pytest/test-lf: pipenv reports/
	$(PIPENV_RUN) pytest -m "not postbuild" --lf
.PHONY: pytest/test-lf

pytest/test-post-build: pipenv reports/
	$(PIPENV_RUN) pytest -m postbuild
.PHONY: pytest/test-post-build
