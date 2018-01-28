default: docker_build

docker_build:
	docker build \
	--squash \
	--build-arg BUILD_DATE=`date -u +"%Y-%m-%dT%H:%M:%SZ"` \
	--build-arg VCS_REF=`git rev-parse --short HEAD` \
	--build-arg VERSION=`cat VERSION` \
	-t docker-rubycoind:alpine \
	-t docker-rubycoind:latest .
