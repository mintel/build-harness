pytest/test: python/env
	@if [[ ! -f "reports/" ]]; then mkdir reports; fi
	$(WITH_PIPENV) pytest -m "not postbuild"

pytest/test-lf: python/env
	@if [[ ! -f "reports/" ]]; then mkdir reports; fi
	$(WITH_PIPENV) pytest -m "not postbuild" --lf

pytest/test-post-build: python/env
	@if [[ ! -f "reports/" ]]; then mkdir reports; fi
	$(WITH_PIPENV) pytest -m postbuild
