#!make
-include .env
export

help: ## Display this help screen
	@grep -h -E '^[a-zA-Z0-9_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

login: ## Log into Dockerhub
	@docker login -u ${DOCKERHUB_USERNAME} -p ${DOCKERHUB_PASSWORD}

build-image: ## Build the Docker image locally
	@docker build --tag ${IMAGE_NAME} -f ./Dockerfile .

push-image: ## Push the Docker image to the Dockerhub container registry
	@ $(MAKE) build-image && \
	docker tag ${IMAGE_NAME} ${DOCKERHUB_NAMESPACE}/${IMAGE_NAME} && \
	docker push ${DOCKERHUB_NAMESPACE}/${IMAGE_NAME}
