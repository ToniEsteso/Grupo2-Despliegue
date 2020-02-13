#!usr/env/bin bash
parametro=$1
docker container stop veganfood_frontend
docker container rm veganfood_frontend
rm -rf ./html/frontend/admin
mkdir -p ./html/frontend/admin
if [ $parametro = "preproduccion" ] || [ $parametro = "Preproduccion" ] || [ $parametro = "PREPRODUCCION" ]; then
    git clone -b develop https://github.com/ToniEsteso/Grupo2-CRUD.git ./html/frontend/admin
elif [ $parametro = "produccion" ] || [ $parametro = "produccion" ] || [ $parametro = "PRODUCCION" ]; then
    git clone https://github.com/ToniEsteso/Grupo2-CRUD.git ./html/frontend/admin
fi
echo "<---------------Frontend clonado--------------->"
chmod -R 777 ./html/frontend/
npm install --prefix ./html/frontend/admin/
npm run build --prefix ./html/frontend/admin/
if [ $parametro = "preproduccion" ] || [ $parametro = "Preproduccion" ] || [ $parametro = "PREPRODUCCION" ]; then
sudo docker container run -d --name veganfood_admin -v /opt/veganfood/html/frontend/admin:/usr/local/apache2/htdocs -p 10330:80 httpd:2.4.41
elif [ $parametro = "produccion" ] || [ $parametro = "produccion" ] || [ $parametro = "PRODUCCION" ]; then
    docker container run -d --name veganfood_admin -v /opt/veganfood/html/frontend/admin:/usr/local/apache2/htdocs --expose 80 -e VIRTUAL_HOST=www.admin.veganfood.pve2.fpmislata.com -e LETSENCRYPT_HOST=www.admin.veganfood.pve2.fpmislata.com --net "nginx-net" httpd:2.4.41
fi
