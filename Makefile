.PHONY: help version build buildongithubactions pushtodockerhub

IS_LATEST        := $(IS_LATEST)
GIT_COMMIT_HASH  := $(shell git rev-parse --short HEAD)

NAME_VENDOR      := bananalab
NAME_PROJECT     := devcontainer
NAME_IMAGE_REPO  := $(NAME_VENDOR)/$(NAME_PROJECT)
GITHUB_API_CREDENTIAL = ${GH_CREDENTIAL}

help:
	@ echo 'Welcome to Makefile of dwchiang/workshop'
	@ echo
	@ echo 'Usage: make [command]'
	@ echo
	@ echo 'Available Commands:'
	@ echo '  version               check version info'
	@ echo '  build                 build base docker image'
	@ echo '  buildongithubactions  buildX On GitHub Actions and push image to Docker Hub'
	@ echo '  pushtodockerhub       buildX On Local and push image to Docker Hub'
	@ echo

version:
	@ echo '{'
	@ echo '  "GIT_COMMIT_HASH":       "$(GIT_COMMIT_HASH)",'
	@ echo '  "IS_LATEST":             "$(IS_LATEST)"'
	@ echo '  "NAME_IMAGE_REPO":       "$(NAME_IMAGE_REPO)"'
	@ echo '}'

build: version
	@ echo '[] Building base image...'
	docker buildx build \
		--load \
		-f Dockerfile \
		-t devcontainer \
		-t $(NAME_IMAGE_REPO):latest \
		-t $(NAME_IMAGE_REPO):$(GIT_COMMIT_HASH) \
		--build-arg BUILDKIT_INLINE_CACHE=1 \
		--build-arg GITHUB_CREDENTIAL=$(GITHUB_API_CREDENTIAL) \
		.

buildongithubactions: version
	@ echo '[] Building image on GitHub Actions...'
ifeq ($(IS_LATEST),true)
	echo 'IS_LATEST=true'

	docker buildx build \
	--push \
	--platform=linux/amd64,linux/arm64 \
	-f Dockerfile \
	--build-arg GITHUB_CREDENTIAL=$(GITHUB_API_CREDENTIAL) \
	-t $(NAME_IMAGE_REPO):latest \
	-t $(NAME_IMAGE_REPO):$(GIT_COMMIT_HASH) .
else
	echo 'IS_LATEST=false or unknown'

	docker buildx build \
	--push \
	--platform=linux/amd64,linux/arm64 \
	-f Dockerfile \
	--build-arg GITHUB_CREDENTIAL=$(GITHUB_API_CREDENTIAL) \
	-t $(NAME_IMAGE_REPO):$(GIT_COMMIT_HASH) .
endif
	@ echo '[] Finished build image on GitHub Actions...'

pushtodockerhub: version
	@ echo '[] Building and pushing to Docker Hub ...'

	docker version
	docker buildx ls
	docker buildx rm buildnginxworkshop || true
	docker buildx ls
	docker buildx create --append --name buildnginxworkshop
	docker buildx use buildnginxworkshop

ifeq ($(IS_LATEST),true)
	echo 'IS_LATEST=true'

	docker buildx build \
	--push \
	--platform=linux/amd64,linux/arm64 \
	-f Dockerfile \
	--build-arg GITHUB_CREDENTIAL=$(GITHUB_API_CREDENTIAL) \
	-t $(NAME_IMAGE_REPO):latest \
	-t $(NAME_IMAGE_REPO):$(GIT_COMMIT_HASH) .
else
	echo 'IS_LATEST=false or unknown'

	docker buildx build \
	--push \
	--platform=linux/amd64,linux/arm64 \
	-f Dockerfile \
	--build-arg GITHUB_CREDENTIAL=$(GITHUB_API_CREDENTIAL) \
	-t $(NAME_IMAGE_REPO):$(GIT_COMMIT_HASH) .
endif

	docker buildx stop
	docker buildx rm buildnginxworkshop

	docker images
