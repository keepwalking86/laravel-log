FROM keepwalking/php8.2-apache-base:latest

WORKDIR /var/www/html

# Copy code into container
COPY . /var/www/html
# Installing dependencies by Composer
#COPY composer.json ./
#COPY composer.lock ./
#RUN composer install --no-dev --no-interaction --no-autoloader --no-scripts
RUN composer install --no-dev --no-interaction --no-scripts

# Clear cache
RUN apt-get clean && rm -fr /var/lib/apt/lists

# Permission for Laravel directories
RUN chown -R www-data:www-data /var/www/html/ && \
    chmod -R 775 /var/www/html/storage

# Expose Apache port
EXPOSE 80

# Run application with vhost
COPY vhost.conf /etc/apache2/sites-available/000-default.conf
RUN chown -R www-data:www-data /var/www/html \
    && a2enmod rewrite
