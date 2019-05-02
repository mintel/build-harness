GIT:= $(shell which git 2>/dev/null)
GITIGNORE_TARGETS ?= python

## Update submodules
git/submodules-update:
	$(call assert-set,GIT)
	$(GIT) submodule update --init --remote

## Update git aliases
git/aliases-update:
	@$(GIT) config --global --add alias.permission-reset '!git diff -p -R --no-color | grep -E "^(diff|(old|new) mode)" --color=never | git apply'

## Export git vars
git/export:
	@echo "GIT_COMMIT=$(GIT_COMMIT)"
	@echo "GIT_COMMIT_SHORT=$(GIT_COMMIT_SHORT)"
	@echo "GIT_COMMIT_TIMESTAMP=$(GIT_COMMIT_TIMESTAMP)"
	@echo "GIT_COMMIT_URL=$(GIT_COMMIT_URL)"
	@echo "GIT_COMMIT_MESSAGE=$(GIT_COMMIT_MESSAGE)"
	@echo "GIT_COMMIT_AUTHOR=$(GIT_COMMIT_AUTHOR)"
	@echo "GIT_BRANCH=$(GIT_BRANCH)"
	@echo "GIT_TAG=$(GIT_TAG)"
	@echo "GIT_BRANCH_TAG=$(GIT_BRANCH_TAG)"
	@echo "GIT_IS_BRANCH=$(GIT_IS_BRANCH)"
	@echo "GIT_IS_TAG=$(GIT_IS_TAG)"
	@echo "GIT_TIMESTAMP=$(GIT_TIMESTAMP)"

## Build .gitignore file if one doesn't exist
git/ignore:
	$(call assert-set,GITIGNORE_TARGETS)
	@if [[ ! -f ".gitignore" ]]; then\
		printf "Generating .gitignore file using https://www.gitignore.io";\
		wget "https://www.gitignore.io/api/$(GITIGNORE_TARGETS)" -O .gitignore;\
		if [[ -f ".gitignore.template" ]]; then\
			printf "\n.build-harness\n" >> .gitignore;\
			printf "\n# From .gitignore.template\n" >> .gitignore;\
			cat .gitignore.template >> .gitignore;\
		fi;\
	else\
		echo "You already have a .gitignore file.";\
	fi

.gitignore: git/ignore
	@exit 0
