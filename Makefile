.PHONY: help version build buildongithubactions pushtodockerhub

IS_LATEST        := $(IS_LATEST)
GIT_COMMIT_HASH  := $(shell git rev-parse --short HEAD)

NAME_VENDOR      := bananalab
NAME_PROJECT     := devcontainer
NAME_IMAGE_REPO  := $(NAME_VENDOR)/$(NAME_PROJECT)

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

	time docker build \
	-f Dockerfile \
	-t $(NAME_IMAGE_REPO):latest .

	docker tag $(NAME_IMAGE_REPO):latest $(NAME_IMAGE_REPO):$(GIT_COMMIT_HASH)

	docker images

buildongithubactions: version
	@ echo '[] Building image on GitHub Actions...'
ifeq ($(IS_LATEST),true)
	echo 'IS_LATEST=true'

	time docker buildx build \
	--push \
	--platform=linux/arm64 \
	-f Dockerfile \
	-t $(NAME_IMAGE_REPO):latest \
	-t $(NAME_IMAGE_REPO):$(GIT_COMMIT_HASH) .
else
	echo 'IS_LATEST=false or unknown'

	time docker buildx build \
	--push \
	--platform=linux/arm64,linux/amd64 \
	-f Dockerfile \
	-t $(NAME_IMAGE_REPO):$(GIT_COMMIT_HASH) .
endif
	@ echo '[] Finished build image on GitHub Actions...'

pushtodockerhub: version
	@ echo '[] Building and pushing to Docker Hub ...'

	docker version
	docker buildx ls
	docker buildx rm buildnginxworkshop
	docker buildx ls
	docker buildx create --append --name buildnginxworkshop
	docker buildx use buildnginxworkshop

ifeq ($(IS_LATEST),true)
	echo 'IS_LATEST=true'

	time docker buildx build \
	--push \
	--platform=linux/amd64,linux/arm64 \
	-f Dockerfile \
	-t $(NAME_IMAGE_REPO):latest \
	-t $(NAME_IMAGE_REPO):$(GIT_COMMIT_HASH) .
else
	echo 'IS_LATEST=false or unknown'

	time docker buildx build \
	--push \
	--platform=linux/amd64,linux/arm64 \
	-f Dockerfile \
	-t $(NAME_IMAGE_REPO):$(GIT_COMMIT_HASH) .
endif

	docker buildx stop
	docker buildx rm buildnginxworkshop

	docker images
