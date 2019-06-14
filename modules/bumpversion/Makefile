BV := $(shell which advbumpversion 2>/dev/null)

## increment the patch version number (i.e. 1.0.0 -> 1.0.1) and do a release.
bumpversion/release_patch:
	$(call assert-set,BV)
	$(BV) patch --verbose
	$(GIT) push --follow-tags
.PHONY: release_patch

## increment the minor version number (i.e. 1.0.0 -> 1.1.0) and do a release.
bumpversion/release_minor:
	$(call assert-set,BV)
	$(BV) minor --verbose
	$(GIT) push --follow-tags
.PHONY: release_minor

## increment the major version number (i.e. 1.0.0 -> 2.0.0) and do a release.
bumpversion/release_major:
	$(call assert-set,BV)
	$(BV) major --verbose
	$(GIT) push --follow-tags
.PHONY: release_major
