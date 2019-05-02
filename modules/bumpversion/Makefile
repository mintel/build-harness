bumpversion/release_patch: python/env ## increment the patch version number (i.e. 1.0.0 -> 1.0.1) and do a release.
	$(shell which bumpversion 2>/dev/null) patch --verbose
	$(GIT) push --follow-tags
.PHONY: release_patch

bumpversion/release_minor: python/env ## increment the minor version number (i.e. 1.0.0 -> 1.1.0) and do a release.
	$(shell which bumpversion 2>/dev/null) minor --verbose
	$(GIT) push --follow-tags
.PHONY: release_minor

bumpversion/release_major: python/env ## increment the major version number (i.e. 1.0.0 -> 2.0.0) and do a release.
	$(shell which bumpversion 2>/dev/null) major --verbose
	$(GIT) push --follow-tags
.PHONY: release_major
