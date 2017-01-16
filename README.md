
Runs `nginx` and `uwsgi` under `supervisor`.

```
UID        PID  PPID  C STIME TTY          TIME CMD
root         1     0  4 04:22 ?        00:00:00 /usr/bin/python /usr/bin/supervisord --nodaemon
root         9     1  0 04:22 ?        00:00:00 nginx: master process /usr/sbin/nginx
root        10     1  4 04:22 ?        00:00:00 /usr/local/bin/uwsgi --ini /var/www/app/uwsgi.ini
www-data    11     9  0 04:22 ?        00:00:00 nginx: worker process
www-data    12     9  0 04:22 ?        00:00:00 nginx: worker process
www-data    13     9  0 04:22 ?        00:00:00 nginx: worker process
www-data    14     9  0 04:22 ?        00:00:00 nginx: worker process

```

[![Build Status](https://travis-ci.org/p0bailey/docker-flask.svg?branch=master)](https://travis-ci.org/p0bailey/docker-flask)


This image is a boilerplate for any Flask application,  pages are served by uwsgi and Nginx.

On Docker host run: docker run -d -p 80:80 p0bailey/docker-flask

On Docker machine run: docker run -d -p 80:80 p0bailey/docker-flask

Docker compose: docker-compose up -d

Source code: https://github.com/p0bailey/docker-flask

DockerHub: https://hub.docker.com/r/p0bailey/docker-flask/

![Hello Flask][2]



[2]: http://s14.postimg.org/mwmg7p0v5/hello_flask.png
