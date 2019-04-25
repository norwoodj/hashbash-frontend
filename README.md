Hash Bash Frontend
==================
This codebase houses the frontend code for the hashbash application. The frontend is built in
[react](https://reactjs.org/). This codebase produces a single artifact necessary to the
deployment of the hashbash application, the `hashbash/nginx` docker image. This image
contains the "compiled" javascript, css, and images for the application, as well as the nginx
config to serve up these assets and to direct API calls to the backed server, built by
a different [codebase](https://github.com/norwoodj/hashbash-java-server).

### Building and Developing Locally
In order to build, run and develop this project locally you'll need a number of things installed:

* docker
* docker-compose
* bash - 4.4 or newer
* make

To build the docker image:
```
make
```

To publish the docker images:
```
make push
```
