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
	rm -fr .coverage htmlcov/ coverage.xml junit.xml junit-*.xml reports/
.PHONY: clean-test
