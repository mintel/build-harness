# Build Harness

This `build-harness` is a collection of Makefiles to facilitate building Python projects, Golang projects, Dockerfiles, and more.
It's designed to work with CI/CD systems such as Travis CI, CircleCI and Jenkins.

**This project is a significant fork of [cloudposse/build-harness](github.com/cloudposse/build-harness). Like it's parent project, it is licensed under the [APACHE2](LICENSE).**

## Screenshots

![demo](https://cdn.rawgit.com/cloudposse/build-harness/master/docs/demo.svg)
*Example of using the `build-harness` to build a docker image*

## Usage

* **STEP 1**: At the top of your `Makefile` add, the following...

  ```makefile
  -include $(shell curl -sSL -o .build-harness "https://git.io/mintel-build-harness"; echo .build-harness)
  ```

  This will download a `Makefile` called `.build-harness` and include it at run-time.

* **STEP 2**: Add `*build-harness*` to your `.gitignore`.

* **STEP 3**: Run `make bh/init` to initialize build-harness.

This automatically exposes many new targets that you can leverage throughout your build & CI/CD process.

Run `make help` for a list of available targets.

**NOTE:** the `/` is interchangeable with the `:` in target names

## Examples

### Generic Python Project

```makefile
-include $(shell curl -sSL -o .build-harness "https://git.io/mintel-build-harness"; echo .build-harness)

# Everything beyond this point is optional, unless your CI/CD relies on specific
# generic target names.

.PHONY: init lint fmt test clean

# This target allows you to consolidate all "bootstrapping" into a single step
# rather than waiting for individual targets to do the needful.
init: bh/init
  @$(MAKE) bh/venv pipenv

lint: python/lint

fmt: python/fmt

test: pytest/test

clean: pipenv/clean python/clean bh/clean
```

## Makefile Targets

```
Available targets:

bash/lint                           Lint all bash scripts
bh/clean                            Clean build-harness
bh/debug                            Debug build-harness
bh/init                             Init build-harness
bumpversion/release_major           Increment the major version number (i.e. 1.0.0 -> 2.0.0) and do a release.
bumpversion/release_minor           Increment the minor version number (i.e. 1.0.0 -> 1.1.0) and do a release.
bumpversion/release_patch           Increment the patch version number (i.e. 1.0.0 -> 1.0.1) and do a release.
compose/build                       Build local dev environment
compose/down                        Stop local dev environment
compose/logs                        Tail logs from docker-compose containers
compose/monitor                     Show containers resource usage
compose/monitor/follow              Monitor in time containers resource usage
compose/ps                          Show default compose ps
compose/purge                       Purge local dev environment
compose/rebuild                     Rebuild custom containers for local dev environment
compose/restart                     Restart local dev environment
compose/top                         Show top for containers
compose/up                          Start local dev environment (daemonized)
django/check                        Run Django check
django/test                         Run Django tests
docker/build                        Build docker image
docker/clean                        Cleanup docker.                     WARNING!!! IT WILL DELETE ALL UNUSED RESOURCES
docker/clean/containers             Cleanup docker containers.          WARNING!!! IT WILL DELETE ALL UNUSED CONTAINERS
docker/clean/images                 Cleanup docker images.              WARNING!!! IT WILL DELETE ALL UNUSED IMAGES
docker/clean/images/all             Cleanup docker images all.          WARNING!!! IT WILL DELETE ALL IMAGES
docker/clean/networks               Cleanup docker networks.            WARNING!!! IT WILL DELETE ALL UNUSED NETWORKS
docker/clean/volumes                Cleanup docker volumes.             WARNING!!! IT WILL DELETE ALL UNUSED VOLUMES
docker/exec                         Open a shell in the main container
docker/image/promote/local          Promote $SOURCE_DOCKER_REGISTRY/$IMAGE_NAME:$SOURCE_VERSION to $TARGET_DOCKER_REGISTRY/$IMAGE_NAME:$TARGET_VERSION
docker/image/promote/remote         Pull $SOURCE_DOCKER_REGISTRY/$IMAGE_NAME:$SOURCE_VERSION and promote to $TARGET_DOCKER_REGISTRY/$IMAGE_NAME:$TARGET_VERSION
docker/image/push                   Push $TARGET_DOCKER_REGISTRY/$IMAGE_NAME:$TARGET_VERSION
docker/login                        Login into docker hub
docker/logs                         Tail logs from docker-compose containers
faas/build/python                   Build python serverless function into a zip
faas/buildif/python                 Build python serverless function if it doesn't exist yet
faas/clean                          Clean up faas artifacts.
git/aliases-update                  Update git aliases
git/export                          Export git vars
git/ignore                          Build .gitignore file if one doesn't exist
git/submodules-update               Update submodules
go/build                            Build binary
go/build-all                        Build binary for all platforms
go/clean                            Clean compiled binary
go/clean-all                        Clean compiled binary and dependency
go/deps                             Install dependencies
go/deps-build                       Install dependencies for build
go/deps-dev                         Install development dependencies
go/fmt                              Format code according to Golang convention
go/install                          Install cli
go/lint                             Lint code
go/test                             Run tests
go/vet                              Vet code
help                                Help screen
help/all                            Display help for all targets
help/short                          This help short screen
make/lint                           Lint all makefiles
packages/delete                     Delete packages
packages/install                    Install packages
packages/install/%                  Install package (e.g. helm, helmfile, kubectl)
packages/reinstall                  Reinstall packages
packages/reinstall/%                Reinstall package (e.g. helm, helmfile, kubectl)
packages/uninstall/%                Uninstall package (e.g. helm, helmfile, kubectl)
pipenv                              Install and activate a virtual environment using pipenv
pipenv/clean                        Remove development virtualenv
pipenv/generate_requirements        Generate requirements files based on a Pipfile
pipenv/lock                         Lock dependencies
python/black                        Reformat python files using black
python/clean                        Clean all unecessary python project files
python/fmt                          Format python files
python/isort                        Fix python import using isort
python/lint                         Check python files using black
readme                              Alias for readme/build
readme/build                        Create README.md by building it from README.yaml
readme/init                         Create basic minimalistic .README.md template file
readme/lint                         Verify the `README.md` is up to date
semver/export                       Export semver vars
template/build                      Create $OUT file by building it from $IN template file
template/deps                       Install dependencies
yarn/%                              Run any `yarn {command}`
yarn/build/%                        Build project
yarn/clean                          Clean node_modules
yarn/init                           Install packages and bootstrap
yarn/install                        Install packages
yarn/lerna/clean                    Clean lerna build artifacts
```
