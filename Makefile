DATE_IMAGE=node:8.11.1-slim
DOCKER_REPOSITORY=jnorwood

nginx: webpack
	docker build --tag $(DOCKER_REPOSITORY)/hashbash-nginx:current --file docker/Dockerfile-nginx .
	touch nginx

webpack: _version.json
	docker build --tag $(DOCKER_REPOSITORY)/hashbash-webpack_builder:current --file docker/Dockerfile-webpack_builder .
	touch webpack

.PHONY: push
push: nginx version.txt
	docker tag $(DOCKER_REPOSITORY)/hashbash-nginx:current $(DOCKER_REPOSITORY)/hashbash-nginx:$(shell cat version.txt)
	docker push $(DOCKER_REPOSITORY)/hashbash-nginx:$(shell cat version.txt)

version.txt:
	echo release-$(shell docker run --entrypoint date $(DATE_IMAGE) --utc "+%Y%m%d-%H%M") > version.txt

_version.json: version.txt
	echo '{"release": "$(shell cat version.txt)"}' > _version.json
	cp _version.json web/src/

.PHONY: run
run: nginx webpack volume
	docker-compose -f docker/docker-compose-hashbash.yaml up

.PHONY: clean
clean:
	rm -f version.txt _version.json nginx webpack volume

volume:
	docker volume create --name=hashbash-data
	touch volume
