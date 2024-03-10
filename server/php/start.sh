#!/bin/bash
set -e

if [ ! -f composer.json ]; then
	rm -Rf tmp/
	/home/server/bin/composer create-project "symfony/skeleton $SYMFONY_VERSION" tmp --stability=stable --prefer-dist --no-progress --no-interaction --no-install

	cd tmp
	cp -Rp . ..
	cd -
	rm -Rf tmp/

	/home/server/bin/composer config --json extra.symfony.docker 'true'
fi

if [ -z "$(ls -A 'vendor/' 2>/dev/null)" ]; then
	/home/server/bin/composer install --prefer-dist --no-progress --no-interaction
fi
