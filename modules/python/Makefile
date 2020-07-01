PYTHON := $(shell which python 2>/dev/null)

PYTHON_TARGETS_FIND_FLAGS=-name "*.py" -not -path "*/.venv/*" -not -path "*/$(BUILD_HARNESS_VENV_NAME)/*" -not -path "*/.tox/*" -not -path "*/.egg*" -not -path "*/frontend/*" -not -path "*/dist/*" -not -path "*/build/*"

PYTHON_LINT_TARGETS?=$(shell find . $(PYTHON_TARGETS_FIND_FLAGS))
PYTHON_SECURITY_TARGETS?=$(shell find . $(PYTHON_TARGETS_FIND_FLAGS) -not -path "*/tests/*")


.PHONY: python/check
python/check: ; $(call assert-set,PYTHON) && echo "Found python: $(PYTHON)"

.PHONY: python/debug
python/debug:
	$(call print-var,PYTHON)

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
