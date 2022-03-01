docker buildx use default

build_image() {
  name=$1
  replaced=${name/\//"-"}
  docker buildx build --pull --platform=linux/$1 --tag=philiplehmann/mailhog:v1.0.1-$replaced .
  docker tag philiplehmann/mailhog:v1.0.1-$replaced philiplehmann/mailhog:latest-$replaced
}
export -f build_image

parallel -kj6 build_image ::: arm64 amd64 ppc64le s390x arm/v7 arm/v6

deploy_image() {
  name=$1
  replaced=${name/\//"-"}
  docker push philiplehmann/mailhog:latest-$replaced
  docker push philiplehmann/mailhog:v1.0.1-$replaced
}
export -f deploy_image

parallel -kj6 deploy_image ::: arm64 amd64 ppc64le s390x arm/v7 arm/v6

docker manifest create --amend philiplehmann/mailhog:v1.0.1 \
                               philiplehmann/mailhog:v1.0.1-arm64 \
                               philiplehmann/mailhog:v1.0.1-amd64 \
                               philiplehmann/mailhog:v1.0.1-ppc64le \
                               philiplehmann/mailhog:v1.0.1-s390x \
                               philiplehmann/mailhog:v1.0.1-arm-v7 \
                               philiplehmann/mailhog:v1.0.1-arm-v6

docker manifest push philiplehmann/mailhog:v1.0.1

docker manifest create --amend philiplehmann/mailhog:latest \
                               philiplehmann/mailhog:latest-arm64 \
                               philiplehmann/mailhog:latest-amd64 \
                               philiplehmann/mailhog:latest-ppc64le \
                               philiplehmann/mailhog:latest-s390x \
                               philiplehmann/mailhog:latest-arm-v7 \
                               philiplehmann/mailhog:latest-arm-v6

docker manifest push philiplehmann/mailhog:latest
