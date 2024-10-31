# Use the official PHP image as a base image (with Apache support)
FROM php:7.4-apache

# Set the timezone
ENV TZ=Asia/Jakarta
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Copy your PHP application to the Apache document root
COPY . /var/www/html

# Set file permissions for the Apache server
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html

# Enable any required Apache or PHP extensions
RUN docker-php-ext-install mysqli pdo pdo_mysql && a2enmod rewrite

# Expose port 80 for the web server
EXPOSE 80

# Start the Apache server
CMD ["apache2-foreground"]
