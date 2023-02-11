docker run --rm --privileged multiarch/qemu-user-static --reset -p yes

docker buildx create --platform linux/arm64,linux/amd64,linux/ppc64le,linux/s390x,linux/arm/v7 --name mailhog-builder
docker buildx use mailhog-builder
docker buildx build --push --no-cache --platform=linux/arm64,linux/amd64,linux/ppc64le,linux/s390x,linux/arm/v7 --tag=philiplehmann/mailhog:v1.1.0-beta1 .

docker buildx imagetools create registry.hub.docker.com/philiplehmann/mailhog:v1.1.0-beta1 --tag registry.hub.docker.com/philiplehmann/mailhog:latest