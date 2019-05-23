reports:
	@if [[ ! -d "reports/" ]]; then mkdir reports; fi

pytest/test: pipenv reports/
	$(WITH_PIPENV) pytest -m "not postbuild"

pytest/test-lf: pipenv reports/
	$(WITH_PIPENV) pytest -m "not postbuild" --lf

pytest/test-post-build: pipenv reports/
	$(WITH_PIPENV) pytest -m postbuild
