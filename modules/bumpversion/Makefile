BUMPVERSION=$(call which,advbumpversion)
BV_VERSION=$(shell test -f .bumpversion.cfg && awk '/current_version[ ]*=[ ]*([0-9\.]*)/' .bumpversion.cfg | awk 'match($$0, /[0-9\.]+/) {print substr($$0, RSTART, RLENGTH)}')

CHANGELOG_PATH ?= CHANGELOG.md

define bv-dry-run
$(shell $(BUMPVERSION) $(1) --dry-run --list --allow-dirty | awk '/new_version[ ]*=[ ]*([0-9\.]*)/' | awk 'match($$0, /[0-9\.]+/) {print substr($$0, RSTART, RLENGTH)}')
endef

define changelog-contains
if [ -n "$$(awk '/^## \[$1/' $(CHANGELOG_PATH))" ]; then exit 0; else echo "[$1] not found in $(CHANGELOG_PATH)"; exit 1; fi
endef

define changelog-exists
@if [ -f $(CHANGELOG_PATH) ]; then $(call changelog-contains,$(call bv-dry-run,$(1))); else echo "Skipping changelog check because $(CHANGELOG_PATH) does not exist in $(CURDIR)"; fi
endef

.PHONY: changelog/exists/%
changelog/exists/%:
	$(call changelog-exists,$*)

.PHONY: bumpversion/debug
bumpversion/debug: bh/venv
	$(call print-var,BUMPVERSION)
	$(call print-var,BV_VERSION)

.PHONY: bumpversion/check
bumpversion/check:
	$(call assert-set,BUMPVERSION)

.PHONY: bumpversion/release_patch
## Increment the patch version number (i.e. 1.0.0 -> 1.0.1)
bumpversion/release_patch: git/require_master bh/venv bumpversion/check changelog/exists/patch
	$(BUMPVERSION) patch --verbose
	$(GIT) push --follow-tags

.PHONY: bumpversion/release_minor
## Increment the minor version number (i.e. 1.0.0 -> 1.1.0)
bumpversion/release_minor: git/require_master bh/venv bumpversion/check changelog/exists/minor
	$(BUMPVERSION) minor --verbose
	$(GIT) push --follow-tags

.PHONY: bumpversion/release_major
## Increment the major version number (i.e. 1.0.0 -> 2.0.0)
bumpversion/release_major: git/require_master bh/venv bumpversion/check changelog/exists/major
	$(BUMPVERSION) major --verbose
	$(GIT) push --follow-tags
