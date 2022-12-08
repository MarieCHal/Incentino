FROM    alpine:3.14

RUN     apk update

# Installation of nginx and openssl
RUN      apk add --no-cache --quiet --update nginx
RUN      apk add --no-cache --quiet --update openssl

# creation of file that will contain the sl key (pour HTTPS)
RUN        mkdir -p /etc/nginx/ssl

# self-signed generation of keys and certificate 
RUN     openssl req -x509 -nodes \
    -out /etc/nginx/ssl/mchalard.42.fr.crt \
    -keyout /etc/nginx/ssl/mchalard.42.fr.key \
    -subj "/C=CH/ST=Lausanne/L=Renens/O=42/OU=42/CN=mchalard.42.fr/UID=mchalard"

#file that is needed by nginx to work
RUN     mkdir -p /var/run/nginx

# coping our conf into the default conf of nginx
COPY    conf/nginx.conf /etc/nginx/http.d/default.conf

# expose only port 443
EXPOSE    443

# Lancement de nginx en premier plan et non en background (les logs seront dans /var/log/nginx) 
# pour que le container ne se stop pas
CMD    [ "nginx", "-g", "daemon off;" ]