# Use an official Apache runtime as a parent image
FROM php:8.2-apache

# Install some dependencies
RUN apt update && apt install -y libicu-dev \
  libz-dev \
  libgd-dev \
  libxslt1-dev \
  libzip-dev \
  libbz2-dev \
  libcurl4-openssl-dev \
  libc-client-dev \
  libkrb5-dev \
  libpq-dev \
  libtidy-dev \
  libfreetype-dev \
  sendmail

# Install the memcache extension
# RUN pecl install memcache && docker-php-ext-enable memcache

# Install the Redis extension
# RUN pecl install redis && docker-php-ext-enable redis

# Install additional PHP extensions
RUN docker-php-ext-configure imap --with-kerberos --with-imap-ssl && \
    docker-php-ext-install mysqli pdo pdo_mysql imap opcache intl gd xsl zip bz2 exif gettext iconv curl pgsql tidy
    

# intl json gd mbstring xml xmlreader xmlwriter xsl zip bz2

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

# Clean up unnecessary files
RUN rm -f /var/www/html/Dockerfile
