include .env
IMAGE_NAME=lapierre/keycloak
IMAGE_VERSION=$(KEYCLOAK_VERSION)

build:
	docker build --pull --build-arg KEYCLOAK_VERSION=$(KEYCLOAK_VERSION) -t $(IMAGE_NAME):$(IMAGE_VERSION) .
	#docker tag $(IMAGE_NAME):$(IMAGE_VERSION) $(IMAGE_NAME):latest

push:
	docker push $(IMAGE_NAME):$(IMAGE_VERSION)
	#docker push $(IMAGE_NAME):latest

github:
	docker buildx build --build-arg KEYCLOAK_VERSION=$(KEYCLOAK_VERSION) --platform linux/arm64/v8,linux/amd64 \
 		--tag "$(IMAGE_NAME):latest" --tag "$(IMAGE_NAME):$(IMAGE_VERSION)" \
 		--output "type=image,push=true" .
