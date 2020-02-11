#!usr/env/bin bash
parametro=$1
docker container stop veganfood_frontend
docker container rm veganfood_frontend
rm -rf ./html/frontend/
mkdir -p ./html/frontend/Grupo2-Cliente
git clone https://github.com/ToniEsteso/Grupo2-Cliente.git ./html/frontend/Grupo2-Cliente
echo "<---------------Frontend clonado--------------->"
chmod -R 777 ./html/frontend/
rm -rf ./html/frontend/Grupo2-Cliente/node_modules
npm install --prefix ./html/frontend/Grupo2-Cliente/
npm run build --prefix ./html/frontend/Grupo2-Cliente/
cp -R ./html/frontend/Grupo2-Cliente/dist/* ./html/frontend
cp ./html/frontend/Grupo2-Cliente/dist/.* ./html/frontend
rm -rf ./html/frontend/Grupo2-Cliente
if [ parametro = "preproduccion" ] || [ parametro = "Preproduccion" ] || [ parametro = "PREPRODUCCION" ]; then
sudo docker container run -d --name veganfood_frontend -v /opt/veganfood/html/frontend:/usr/local/apache2/htdocs -p 10320:80 httpd:2.4.41
elif [ parametro = "produccion" ] || [ parametro = "produccion" ] || [ parametro = "PRODUCCION" ]; then
    docker container run -d --name veganfood_frontend -v /opt/veganfood/html/frontend:/usr/local/apache2/htdocs --expose 80 -e VIRTUAL_HOST=www.veganfood.pve2.fpmislata.com -e LETSENCRYPT_HOST=www.veganfood.pve2.fpmislata.com --net "nginx-net" httpd:2.4.41
fi
docker exec -it veganfood_frontend sed -i "s/AllowOverride None/AllowOverride All/g" conf/httpd.conf
