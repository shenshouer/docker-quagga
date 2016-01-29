FROM        alpine
MAINTAINER  shenshouer51@gmail.com
ENV         BUILD_AT 2016-01-29
RUN         apk add --update quagga supervisor
ADD         supervisord.conf /etc/supervisord.conf
VOLUME /etc/quagga
EXPOSE 179 2601 2605
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]