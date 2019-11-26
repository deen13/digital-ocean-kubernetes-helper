FROM alpine:3.10

ENV KUBECTL_VERSION 1.16.0
ENV DOCTL_VERSION 1.33.1

WORKDIR /

RUN apk --update add curl tar

# Install kubectl
ADD https://storage.googleapis.com/kubernetes-release/release/v${KUBECTL_VERSION}/bin/linux/amd64/kubectl /usr/local/bin/kubectl
RUN chmod +x /usr/local/bin/kubectl

# Install doctl
RUN cd /usr/local/bin && \
  curl -sL https://github.com/digitalocean/doctl/releases/download/v${DOCTL_VERSION}/doctl-${DOCTL_VERSION}-linux-amd64.tar.gz | tar -xz

# install kustomize
RUN  curl -L --output /tmp/kustomize_v3.3.0_linux_amd64.tar.gz https://github.com/kubernetes-sigs/kustomize/releases/download/kustomize%2Fv3.3.0/kustomize_v3.3.0_linux_amd64.tar.gz \
  && echo "4b49e1bbdb09851f11bb81081bfffddc7d4ad5f99b4be7ef378f6e3cf98d42b6  /tmp/kustomize_v3.3.0_linux_amd64.tar.gz" | sha256sum -c \
  && tar -xvzf /tmp/kustomize_v3.3.0_linux_amd64.tar.gz -C /usr/local/bin \
  && chmod +x /usr/local/bin/kustomize
