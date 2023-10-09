DOCKER_REPOSITORY := jnorwood

build: dist

release:
	./scripts/release.sh

node_modules:
	npm install

dist: node_modules version.json
	mv version.json src/frontend-version.json
	./node_modules/webpack/bin/webpack.js -p --progress

version.json:
	echo '{"build_timestamp": "$(shell date --utc --iso-8601=seconds)", "git_revision": "$(shell git rev-parse HEAD)", "version": "$(shell git describe)"}' | jq . > version.json

deb:
	debuild

nginx: version.json
	mv version.json src/frontend-version.json
	docker-compose -f docker/docker-compose-hashbash.yaml build nginx

webpack-builder: version.json
	mv version.json src/frontend-version.json
	docker-compose -f docker/docker-compose-hashbash.yaml build webpack_builder

push: nginx
	docker tag $(DOCKER_REPOSITORY)/hashbash-nginx $(DOCKER_REPOSITORY)/hashbash-nginx:$(shell git tag -l | tail -n 1)
	docker push $(DOCKER_REPOSITORY)/hashbash-nginx:$(shell git tag -l | tail -n 1)


run: version.json
	mv version.json src/frontend-version.json
	docker-compose -f docker/docker-compose-hashbash.yaml up

down:
	docker-compose -f docker/docker-compose-hashbash.yaml down --volumes

clean:
	rm -rvf dist version.json src/frontend-version.json update-versions
