# alpine-vsftpd

FROM alpine:latest
MAINTAINER Towdium <towdium@gmail.com>
ARG HTTP_PROXY
ARG CSR_INFO

# install vsftpd
RUN apk add --no-cache vsftpd openssl

# generate TLS cerrtificate
RUN openssl req -x509 -nodes -days 365 \
 -newkey rsa:1024 -subj $CSR_INFO \
 -keyout /etc/ssl/private/vsftpd.pem \
 -out /etc/ssl/private/vsftpd.pem

# configure vsftpd
COPY vsftpd.conf /etc/vsftpd.conf

# make example site
RUN mkdir /srv/ftp \
 && mkdir /srv/ftp/Upload \
 && chmod a+w /srv/ftp/Upload \
 && echo "# FTP Demo" > /srv/ftp/README.md \
 && mkdir /srv/Download

CMD vsftpd

EXPOSE 20-21
EXPOSE 9000-9099
