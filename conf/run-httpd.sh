#!/bin/bash

# Set our PHP ini environment variable defauts.
if [[ ! -n "${PHP_DISPLAY_ERRORS}" ]]; then
  export PHP_DISPLAY_ERRORS=Off
fi
if [[ ! -n "${PHP_DISPLAY_STARTUP_ERRORS}" ]]; then
  export PHP_DISPLAY_STARTUP_ERRORS=Off
fi
if [[ ! -n "${PHP_MAX_EXECUTION_TIME}" ]]; then
  export PHP_MAX_EXECUTION_TIME=300
fi
if [[ ! -n "${PHP_MAX_INPUT_TIME}" ]]; then
  export PHP_MAX_INPUT_TIME=300
fi
if [[ ! -n "${PHP_MAX_INPUT_VARS}" ]]; then
  export PHP_MAX_INPUT_VARS=1000
fi
if [[ ! -n "${PHP_MEMORY_LIMIT}" ]]; then
  export PHP_MEMORY_LIMIT=386M
fi
if [[ ! -n "${PHP_POST_MAX_SIZE}" ]]; then
  export PHP_POST_MAX_SIZE=256M
fi
if [[ ! -n "${PHP_UPLOAD_MAX_FILESIZE}" ]]; then
  export PHP_UPLOAD_MAX_FILESIZE=256M
fi

envsubst < /etc/php/7.4/apache2/php.ini > /etc/php/7.4/apache2/php2.ini
envsubst < /etc/php/7.4/cli/php.ini > /etc/php/7.4/cli/php2.ini
mv -f /etc/php/7.4/apache2/php2.ini /etc/php/7.4/apache2/php.ini
mv -f /etc/php/7.4/cli/php2.ini /etc/php/7.4/cli/php.ini

chmod -R 775 /var/www/html/web/videos
chown -R www-data:www-data /var/www/html/web/videos

service apache2 start

touch ~/placeholder.txt
tail -f ~/placeholder.txt
