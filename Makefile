DATE_IMAGE=node:8.11.1-slim
DOCKER_REPOSITORY=jnorwood

.PHONY: nginx webpack push clean


nginx: webpack
	docker build --tag $(DOCKER_REPOSITORY)/hashbash-nginx:current --file docker/Dockerfile-nginx .

webpack: version.txt
	docker build --tag $(DOCKER_REPOSITORY)/hashbash-webpack_builder:current --file docker/Dockerfile-webpack_builder .

push: nginx version.txt
	docker tag $(DOCKER_REPOSITORY)/hashbash-nginx:current $(DOCKER_REPOSITORY)/hashbash-nginx:$(shell cat version.txt)
	docker push $(DOCKER_REPOSITORY)/hashbash-nginx:$(shell cat version.txt)

version.txt:
	echo release-$(shell docker run --entrypoint date $(DATE_IMAGE) --utc "+%Y%m%d-%H%M") > version.txt

clean:
	rm -f version.txt
