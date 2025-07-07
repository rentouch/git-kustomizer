FROM alpine:latest

RUN apk update && \
    apk add --no-cache yq bash curl git openssh py3-pip

# Create a virtual environment for Python
RUN python3 -m venv /opt/venv

# Install yamlfix in the venv and make it available globally
RUN /opt/venv/bin/pip install --upgrade pip && \
    /opt/venv/bin/pip install yamlfix
RUN ln -s /opt/venv/bin/yamlfix /usr/local/bin/yamlfix

# Install kustomize
RUN curl -s "https://raw.githubusercontent.com/kubernetes-sigs/kustomize/master/hack/install_kustomize.sh" | bash && mv kustomize /usr/local/bin

ENV PATH="/opt/venv/bin:$PATH"

CMD ["/bin/sh"] 