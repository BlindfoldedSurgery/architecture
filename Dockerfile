FROM python:3.11 AS base

WORKDIR /app

ENV PYTHONUNBUFFERED 1

COPY requirements.txt requirements.txt

RUN pip install -r requirements.txt

COPY mkdocs.yml mkdocs.yml

ENTRYPOINT [ "mkdocs" ]

FROM base AS builder

ENV ENABLE_GIT_PLUGIN=1
COPY .git/ .git/
COPY docs/ docs/

RUN mkdocs build

FROM nginxinc/nginx-unprivileged:1.25.3

COPY --from=builder /app/site /usr/share/nginx/html
