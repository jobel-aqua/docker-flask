FROM ubuntu:16.04
MAINTAINER Phillip Bailey <phillip@bailey.st>

ENV DEBIAN_FRONTEND noninteractive

# Use a local Dockerized apt-cache: https://docs.docker.com/engine/examples/apt-cacher-ng/
# RUN  echo 'Acquire::http { Proxy "http://192.168.0.10:3142"; };' >> /etc/apt/apt.conf.d/01proxy

RUN apt-get update && apt-get install -y \
    python-pip python-dev uwsgi-plugin-python \
    nginx supervisor && pip install --upgrade pip

COPY ./nginx/flask.conf /etc/nginx/sites-available/
COPY ./supervisor/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY ./app /var/www/app
WORKDIR /var/www/app

RUN pip install -r /var/www/app/requirements.txt

RUN mkdir -p /var/log/nginx/app /var/log/uwsgi/app /var/log/supervisor \
    && rm /etc/nginx/sites-enabled/default \
    && ln -s /etc/nginx/sites-available/flask.conf /etc/nginx/sites-enabled/flask.conf \
    && echo "daemon off;" >> /etc/nginx/nginx.conf \
    && chown -R www-data:www-data /var/www/app \
    && chown -R www-data:www-data /var/log

# forward request and error logs to docker log collector
RUN ln -sf /dev/stdout /var/log/nginx/app/access.log \
	&& ln -sf /dev/stderr /var/log/nginx/app/error.log

CMD ["/usr/bin/supervisord"]
