FROM palamccc/alpine-php-fpm
RUN apk add --no-cache s6
RUN mkdir -p /etc/s6/php-fpm7 \
  && ln -s /usr/sbin/php-fpm7 /etc/s6/php-fpm7/run \
  && mkdir -p /etc/s6/crond \
  && { \
    echo "#!/bin/sh"; \
    echo "exec crond -f"; \
  } > /etc/s6/crond/run \
  && chmod +x /etc/s6/crond/run
# provide crontab file /var/spool/cron/crontabs/root with --volume option
CMD ["s6-svscan", "/etc/s6"]
