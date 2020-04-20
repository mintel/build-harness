pytest: pytest/test
.PHONY: pytest

pytest/test: pipenv reports/
	$(WITH_PIPENV) pytest -m "not postbuild"
.PHONY: pytest/test

pytest/test-lf: pipenv reports/
	$(WITH_PIPENV) pytest -m "not postbuild" --lf
.PHONY: pytest/test-lf

pytest/test-post-build: pipenv reports/
	$(WITH_PIPENV) pytest -m postbuild
.PHONY: pytest/test-post-build
