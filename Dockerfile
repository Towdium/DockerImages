# nginx-gunicorn-flask

FROM centos:7
MAINTAINER Towdium <towdium@gmail.com>

# set yum and pip proxy
RUN cp /etc/yum.conf /etc/yum.conf.bak \
 && ([ -z "$HTTP_PROXY" ] || echo proxy=http://$HTTP_PROXY >> /etc/yum.conf) \
 && if [ -z "$HTTP_PROXY" ]; then _py_proxy=""; else _py_proxy="--proxy=http://$HTTP_PROXY"; fi

# install packages
RUN yum update && yum install -y epel-release python \
 && yum install -y python-pip nginx \
 && pip install $_py_proxy --upgrade pip virtualenv gunicorn supervisor

# setup example app, nginx and supervisord
COPY app /deploy/app
COPY nginx.conf /etc/nginx/nginx.conf
COPY supervisord.conf /etc/supervisord.conf

# unset proxy
RUN yes | cp -f /etc/yum.conf.bak /etc/yum.conf \
 && rm -f /etc/yum.conf.bak \
 && unset _py_proxy
 
# For run as bash:
# CMD ([ -z "$HTTP_PROXY" ] || echo proxy=http://$HTTP_PROXY >> /etc/yum.conf) \
#  && if [ -z "$HTTP_PROXY" ]; then _py_proxy=""; else _py_proxy="--proxy=http://$HTTP_PROXY"; fi \
#  && pip install $_py_proxy $(cat /deploy/app/requirements.txt) > dev/null \
#  && bash

CMD if [ -z "$HTTP_PROXY" ]; then _py_proxy=""; else _py_proxy="--proxy=http://$HTTP_PROXY"; fi \
 && pip install $_py_proxy $(cat /deploy/app/requirements.txt) > dev/null \
 && unset _py_proxy \
 && supervisord

