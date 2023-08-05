DOCKER_REPOSITORY := jnorwood

build: dist

release:
	./scripts/release.sh

node_modules:
	npm install

dist: node_modules version.json
	mv version.json src/
	./node_modules/webpack/bin/webpack.js -p --progress

version.json:
	echo '{"build-timestamp": "$(shell date --utc --iso-8601=seconds)", "revision": "$(shell git rev-parse HEAD)", "version": "$(shell cat version.txt)"}' | jq . > version.json

deb:
	debuild

nginx: version.json
	mv version.json src/
	docker-compose -f docker/docker-compose-hashbash.yaml build nginx

push: nginx
	docker tag $(DOCKER_REPOSITORY)/hashbash-nginx:current $(DOCKER_REPOSITORY)/hashbash-nginx:$(shell cat version.txt)
	docker push $(DOCKER_REPOSITORY)/hashbash-nginx:$(shell cat version.txt)


run: version.json
	mv version.json src/
	docker-compose -f docker/docker-compose-hashbash.yaml up

down:
	docker-compose -f docker/docker-compose-hashbash.yaml down --volumes

clean:
	rm -rvf dist version.json src/version.json version.txt update-versions
