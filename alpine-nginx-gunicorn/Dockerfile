# alpine-nginx-gunicorn

FROM alpine:latest
LABEL maintainer="towdium@gmail.com"

RUN if [ -z "$HTTP_PROXY" ]; then py_proxy=""; \
 else py_proxy="--proxy=$HTTP_PROXY"; fi \
 && apk add --no-cache python py-pip nginx \
 && pip install $py_proxy supervisor gunicorn \
 && unset py_proxy \
 && mkdir /run/nginx

COPY app /deploy/app
COPY nginx.conf /etc/nginx/nginx.conf
COPY supervisord.conf /etc/supervisord.conf

CMD if [ -z "$HTTP_PROXY" ]; then py_proxy=""; \
 else py_proxy="--proxy=$HTTP_PROXY"; fi \
 && echo "Installing python packages." \
 && pip install $py_proxy $(cat /deploy/app/requirements.txt) \
 && unset py_proxy \
 && supervisord
