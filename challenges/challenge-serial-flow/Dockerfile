FROM python:3.12-alpine

RUN apk update \
    && apk add --no-cache --update memcached libmemcached-dev zlib-dev build-base supervisor

RUN python -m pip install --upgrade pip

COPY flag.txt /flag.txt

RUN mkdir -p /app

WORKDIR /app

COPY challenge .

RUN pip install --no-cache-dir -r requirements.txt

COPY supervisord.conf /etc/supervisord.conf

EXPOSE 1337

# Disable pycache
ENV PYTHONDONTWRITEBYTECODE=1

# Create database and start supervisord
COPY --chown=root entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
