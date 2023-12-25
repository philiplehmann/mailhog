#
# MailHog Dockerfile
#

FROM golang:1.21-bookworm as builder

# Install MailHog:
RUN apt update \
  && apt install -y build-essential git \
  && mkdir -p /root/gocode \
  && export GOPATH=/root/gocode \
  && go install github.com/mailhog/MailHog@v1.0.1

FROM debian:stable-slim
RUN apt update && apt upgrade -y
RUN useradd -ms /bin/bash -u 1000 mailhog

COPY --from=builder /root/gocode/bin/MailHog /usr/local/bin/

USER mailhog

WORKDIR /home/mailhog

ENTRYPOINT ["MailHog"]

# Expose the SMTP and HTTP ports:
EXPOSE 1025 8025