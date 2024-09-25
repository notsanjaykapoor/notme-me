FROM python:3.12.4-slim as runner

ENV PYTHONUNBUFFERED=1 UV_HTTP_TIMEOUT=60

RUN apt-get -y update && \
    apt-get install -y build-essential busybox curl dnsutils gcc gettext git git-lfs netcat-traditional postgresql-client tmux && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY --from=ghcr.io/astral-sh/uv:latest /uv /bin/uv
COPY pyproject.toml uv.lock ./

FROM runner as base
ARG APP_VERSION=version
WORKDIR /app
ADD . ./
RUN uv sync --frozen