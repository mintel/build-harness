.PHONY: python/debug
python/debug:
	$(call print-var,PY_PIPFILE_EXISTS)
	$(call print-var,PY_CURRENT_VENV)
	$(call print-var,PY_VENV)
	$(call print-var,PIPENV)
	$(call print-var,WITH_PIPENV)

## Clean all unecessary python project files
python/clean: python/clean/pyc python/clean/dist python/clean/docs python/clean/test
.PHONY: python/clean

python/clean/pyc:
	find . -name '*.pyc' -exec rm -f {} +
	find . -name '*.pyo' -exec rm -f {} +
	find . -name '*~' -exec rm -f {} +
	find . -name '__pycache__' -exec rm -fr {} +
.PHONY: python/clean/pyc

python/clean/dist:
	rm -fr build/ dist/ .eggs/ requirements*.txt
	find . -name '*.egg-info' -exec rm -fr {} +
	find . -name '*.egg' -exec rm -f {} +
.PHONY: python/clean/dist

python/clean/docs:
	rm -rf docs/_build/*
.PHONY: clean-docs

python/clean/test:
	rm -fr htmlcov/ coverage.xml .coverage .coverage.* *.cover junit.xml junit-*.xml reports/ .pytest_cache/
.PHONY: clean-test
