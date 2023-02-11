#
# MailHog Dockerfile
#

FROM golang:latest as builder

# Install MailHog:
RUN apt-get update \
  && apt-get install -y build-essential git \
  && mkdir -p /root/gocode \
  && export GOPATH=/root/gocode \
  && go install github.com/mailhog/MailHog@v1.1.0-beta1

FROM debian:stable-slim
RUN apt-get update && apt-get upgrade -y
RUN useradd -ms /bin/bash -u 1000 mailhog

COPY --from=builder /root/gocode/bin/MailHog /usr/local/bin/

USER mailhog

WORKDIR /home/mailhog

ENTRYPOINT ["MailHog"]

# Expose the SMTP and HTTP ports:
EXPOSE 1025 8025