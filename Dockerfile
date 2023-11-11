# Use an official Apache runtime as a parent image
FROM php:8.2-apache

# Install some dependencies
RUN apt update && apt install -y libicu-dev gcc c++ autoconf

# Install necessary build dependencies
RUN apt install -y zlib-dev libmemcached-dev

# Install the memcache extension
RUN pecl install memcache && docker-php-ext-enable memcache

# Install the Redis extension
RUN pecl install redis && docker-php-ext-enable redis

# Install additional PHP extensions
RUN docker-php-ext-install mysqli pdo pdo_mysql opcache intl json gd mbstring xml xmlreader xmlwriter xsl zip bz2

# json gd mbstring xml xmlreader xmlwriter xsl zip bz2 exif gettext iconv curl imap pgsql simplexml tidy

# Enable Apache modules
RUN a2enmod rewrite
RUN a2enmod headers

# Set the working directory to /var/www/html
WORKDIR /var/www/html

# Copy the current directory contents into the container at /var/www/html
COPY . /var/www/html

# Create a volume for web files
VOLUME /var/www/html

# Expose port 80 for Apache
EXPOSE 80

# Start Apache when the container launches
CMD ["apache2-foreground"]
