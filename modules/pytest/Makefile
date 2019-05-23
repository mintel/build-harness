reports/:
	@if [[ ! -d "reports/" ]]; then mkdir reports; fi

pytest/test: python/env reports/
	$(WITH_PIPENV) pytest -m "not postbuild"

pytest/test-lf: python/env reports/
	$(WITH_PIPENV) pytest -m "not postbuild" --lf

pytest/test-post-build: python/env reports/
	$(WITH_PIPENV) pytest -m postbuild
