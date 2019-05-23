## Clean all unecessary python project files
python/clean: python/clean/pyc python/clean/dist
.PHONY: python/clean

python/clean/pyc:
	find . -name '*.pyc' -exec rm -f {} +
	find . -name '*.pyo' -exec rm -f {} +
	find . -name '*~' -exec rm -f {} +
	find . -name '__pycache__' -exec rm -fr {} +
.PHONY: python/clean/pyc

python/clean/dist:
	rm -fr build/
	rm -fr dist/
	rm -fr .eggs/
	find . -name '*.egg-info' -exec rm -fr {} +
	find . -name '*.egg' -exec rm -f {} +
.PHONY: python/clean/dist

python/clean/docs:
	rm -rf docs/_build/*
.PHONY: clean-docs

python/clean/test:
	rm -f .coverage
	rm -fr htmlcov/
	rm -fr coverage.xml
	rm -fr junit.xml
	rm -fr junit-*.xml
	rm -fr reports/
.PHONY: clean-test
