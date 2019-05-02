pytest/test: python/env
	@if [[ ! -d "reports/" ]]; then mkdir reports; fi
	$(WITH_PIPENV) pytest -m "not postbuild"

pytest/test-lf: python/env
	@if [[ ! -d "reports/" ]]; then mkdir reports; fi
	$(WITH_PIPENV) pytest -m "not postbuild" --lf

pytest/test-post-build: python/env
	@if [[ ! -d "reports/" ]]; then mkdir reports; fi
	$(WITH_PIPENV) pytest -m postbuild
