FROM python:3.12.4-slim as runner

ENV PYTHONUNBUFFERED=1 UV_HTTP_TIMEOUT=60

RUN apt-get -y update && \
    apt-get install -y busybox curl dnsutils gcc gettext git git-lfs netcat-traditional postgresql-client tmux && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY requirements.txt ./
# install uv, use uv to install packages into system python environment
RUN curl -LsSf https://astral.sh/uv/install.sh | sh && \
    mv /root/.cargo/bin/uv /usr/local/bin && \
    uv pip install -r requirements.txt --system

FROM runner as base
ARG APP_VERSION=version
WORKDIR /app
ADD . ./