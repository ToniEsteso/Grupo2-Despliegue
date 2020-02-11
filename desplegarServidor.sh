#!usr/env/bin bash
parametro=$1
echo "PARAMETRO"
echo $parametro
echo "PARAMETRO"
docker container stop veganfood_backend
docker container rm veganfood_backend
rm -rf ./html/backend/Grupo2-Servidor
mkdir -p ./html/backend/Grupo2-Servidor
if [ $parametro = "preproduccion" ] || [ $parametro = "Preproduccion" ] || [ $parametro = "PREPRODUCCION" ]; then
    git clone -b develop https://github.com/ToniEsteso/Grupo2-Servidor.git ./html/backend/Grupo2-Servidor
elif [ $parametro = "produccion" ] || [ $parametro = "produccion" ] || [ $parametro = "PRODUCCION" ]; then
    git clone https://github.com/ToniEsteso/Grupo2-Servidor.git ./html/backend/Grupo2-Servidor
fi
echo "<---------------Backend clonado--------------->"
chmod -R 777 ./html/backend/
if [ $parametro = "preproduccion" ] || [ $parametro = "Preproduccion" ] || [ $parametro = "PREPRODUCCION" ]; then
    docker container run -d --name veganfood_backend -v /opt/veganfood/html/backend/Grupo2-Servidor:/var/www/html -p 10310:80 php:7.3-apache
elif [ $parametro = "produccion" ] || [ $parametro = "Produccion" ] || [ $parametro = "PRODUCCION" ]; then
    echo "ENTRADO"
    docker container run -d --name veganfood_backend -v /opt/veganfood/html/backend/Grupo2-Servidor:/var/www/html --expose 80 -e VIRTUAL_HOST=www.api.veganfood.pve2.fpmislata.com -e LETSENCRYPT_HOST=www.api.veganfood.pve2.fpmislata.com --net "nginx-net" php:7.3-apache
fi
docker exec -it veganfood_backend a2enmod rewrite
docker exec -it veganfood_backend docker-php-ext-install pdo pdo_mysql
docker restart  veganfood_backend
