docker buildx build --platform=linux/arm64 --tag=philiplehmann/mailhog:latest-arm64 .
docker buildx build --platform=linux/amd64 --tag=philiplehmann/mailhog:latest-amd64 .
# docker buildx build --platform=linux/riscv64 --tag=philiplehmann/mailhog:latest-riscv64 .
docker buildx build --platform=linux/ppc64le --tag=philiplehmann/mailhog:latest-ppc64le .
docker buildx build --platform=linux/s390x --tag=philiplehmann/mailhog:latest-s390x .
# docker buildx build --platform=linux/386 --tag=philiplehmann/mailhog:latest-386 .
docker buildx build --platform=linux/arm/v7 --tag=philiplehmann/mailhog:latest-armv7 .
docker buildx build --platform=linux/arm/v6 --tag=philiplehmann/mailhog:latest-armv6 .

docker push philiplehmann/mailhog:latest-arm64
docker push philiplehmann/mailhog:latest-amd64
# docker push philiplehmann/mailhog:latest-riscv64
docker push philiplehmann/mailhog:latest-ppc64le
docker push philiplehmann/mailhog:latest-s390x
# docker push philiplehmann/mailhog:latest-386
docker push philiplehmann/mailhog:latest-armv7
docker push philiplehmann/mailhog:latest-armv6



docker manifest create --amend philiplehmann/mailhog:latest \
                                                    philiplehmann/mailhog:latest-arm64 \
                                                    philiplehmann/mailhog:latest-amd64 \
                                                    philiplehmann/mailhog:latest-ppc64le \
                                                    philiplehmann/mailhog:latest-s390x \
                                                    philiplehmann/mailhog:latest-armv7 \
                                                    philiplehmann/mailhog:latest-armv6

docker manifest push philiplehmann/mailhog:latest