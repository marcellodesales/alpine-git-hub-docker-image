# alpine-git-hub-docker-image

alpine based git + https://github.com/github/hub github extention https://hub.github.com/

# Make Releases

Releases with github/hub is at https://hub.github.com/hub-release.1.html. More info at https://hub.github.com/hub.1.html.

* Create a git tag and push it
* Make tar.gz files of your binaries


```makefile
PWD = $(CURDIR)
DIST_DIR = dist
APP_NAME = protocool
ORG = new-project
BIN_VERSION ?= 0.8.0
PUBLISH_GITHUB_USER = svc-company-platform-automation
PUBLISH_GITHUB_TOKEN = fcc17******e8203
PUBLISH_GITHUB_HOST = github.company.com
PUBLISH_GITHUB_ORG = grpc
PUBLISH_GITHUB_HOST = github.company.com

publish: dist ## Publishes the built binaries in Github Releases
  git tag v$(BIN_VERSION) && git push origin v$(BIN_VERSION) || true
  tar -czvf dist/$(APP_NAME)-darwin-amd64.tar.gz dist/$(APP_NAME)-darwin-amd64
  tar -czvf dist/$(APP_NAME)-linux-amd64.tar.gz dist/$(APP_NAME)-linux-amd64
  zip -r dist/$(APP_NAME)-windows-amd64.zip dist/$(APP_NAME)-windows-amd64.exe
  docker run -ti -e GITHUB_HOST=$(PUBLISH_GITHUB_HOST) -e GITHUB_USER=$(PUBLISH_GITHUB_USER) \
                 -e GITHUB_TOKEN=$(PUBLISH_GITHUB_TOKEN) -e GITHUB_REPOSITORY=$(PUBLISH_GITHUB_ORG)/$(APP_NAME) \
                 -e HUB_PROTOCOL=https \
                 -v $(PWD):/git marcellodesales/github-hub release create \
                          --prerelease --attach dist/$(APP_NAME)-darwin-amd64.tar.gz \
                          --attach dist/$(APP_NAME)-linux-amd64.tar.gz \
                          --attach dist/$(APP_NAME)-windows-amd64.zip \
                          -m "protocool $(BIN_VERSION) release" v$(BIN_VERSION)
```
