FROM wordpress:php8.1-apache

# Surcharge uniquement wp-content
COPY custom-content/ /var/www/html/wp-content/

# Azure App Service attend un conteneur qui écoute sur le port 80
EXPOSE 80

# Lancement explicite du serveur Apache (normalement déjà dans l'image, mais ici on est explicite pour Azure)
CMD ["apache2-foreground"]

RUN echo -e "User-agent: *\nDisallow: /" > /var/www/html/robots933456.txt
