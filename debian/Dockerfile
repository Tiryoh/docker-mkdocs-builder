FROM python:3.9.16-slim-buster

ARG MKDOCS_ENV=production

ENV MKDOCS_ENV=${MKDOCS_ENV} \
    # python:
    PYTHONFAULTHANDLER=1 \
    PYTHONUNBUFFERED=1 \
    PYTHONHASHSEED=random \
    PYTHONDONTWRITEBYTECODE=1 \
    # pip:
    PIP_NO_CACHE_DIR=off \
    PIP_DISABLE_PIP_VERSION_CHECK=on \
    PIP_DEFAULT_TIMEOUT=100 \
    # poetry:
    POETRY_VERSION=1.3.2 \
    POETRY_NO_INTERACTION=1 \
    POETRY_VIRTUALENVS_CREATE=false \
    POETRY_CACHE_DIR='/var/cache/pypoetry' \
    PATH="$PATH:/root/.local/bin"

# Install system deps
RUN apt-get update && \
    apt-get install --no-install-recommends -y \
        bash curl git libcairo2 && \
    # Installing `poetry` package manager:
    # https://github.com/python-poetry/poetry
    curl -sSL https://install.python-poetry.org | python3 - || { cat /poetry*.log; exit 1; } && \
    poetry --version && \
    apt-get purge -y curl && \
    apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false && \
    apt-get clean -y && \
    rm -rf rm -rf /var/lib/apt/lists/*

# Copy only requirements to cache them in docker layer
COPY poetry.lock pyproject.toml /docs/

# Set working directory
WORKDIR /docs

# Initialize project
RUN echo "MKDOCS_ENV: "${MKDOCS_ENV} && \
    poetry install \
    $(if [ "$MKDOCS_ENV" = 'production' ]; then echo '--no-dev'; fi) \
    --no-interaction --no-ansi && \
    if [ "$MKDOCS_ENV" = 'production' ]; then rm -rf "$POETRY_CACHE_DIR"; fi

# Expose MkDocs development server port
EXPOSE 8000

# Start development server by default
ENTRYPOINT ["mkdocs"]
CMD ["serve", "--dev-addr=0.0.0.0:8000"]
