DATE_IMAGE=node:8.11.1-slim
DOCKER_REPOSITORY=jnorwood

.PHONY: nginx
nginx: webpack
	docker build --tag $(DOCKER_REPOSITORY)/hashbash-nginx:current --file docker/Dockerfile-nginx .

.PHONY: webpack
webpack: version.txt
	docker build --tag $(DOCKER_REPOSITORY)/hashbash-webpack_builder:current --file docker/Dockerfile-webpack_builder .

.PHONY: push
push: nginx version.txt
	docker tag $(DOCKER_REPOSITORY)/hashbash-nginx:current $(DOCKER_REPOSITORY)/hashbash-nginx:$(shell cat version.txt)
	docker push $(DOCKER_REPOSITORY)/hashbash-nginx:$(shell cat version.txt)

version.txt:
	echo release-$(shell docker run --entrypoint date $(DATE_IMAGE) --utc "+%Y%m%d-%H%M") > version.txt

.PHONY: run
run: nginx webpack
	docker-compose -f docker/docker-compose-hashbash.yaml up

.PHONY: clean
clean:
	rm -f version.txt
