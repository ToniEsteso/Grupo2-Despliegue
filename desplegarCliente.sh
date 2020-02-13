#!usr/env/bin bash
parametro=$1
sudo docker container stop veganfood_frontend
sudo docker container rm veganfood_frontend
sudo rm -rf ./html/frontend/
sudo mkdir -p ./html/frontend/Grupo2-Cliente
if [ $parametro = "preproduccion" ] || [ $parametro = "Preproduccion" ] || [ $parametro = "PREPRODUCCION" ]; then
    sudo git clone -b develop https://github.com/ToniEsteso/Grupo2-Cliente.git ./html/frontend/Grupo2-Cliente
elif [ $parametro = "produccion" ] || [ $parametro = "produccion" ] || [ $parametro = "PRODUCCION" ]; then
    sudo git clone https://github.com/ToniEsteso/Grupo2-Cliente.git ./html/frontend/Grupo2-Cliente
fi
echo "<---------------Frontend clonado--------------->"
sudo chmod -R 777 ./html/frontend/
sudo rm -rf ./html/frontend/Grupo2-Cliente/node_modules
sudo npm install --prefix ./html/frontend/Grupo2-Cliente/
sudo chmod -R 777 ./html/frontend/
sudo npm run build --prefix ./html/frontend/Grupo2-Cliente/
sudo mkdir ./html/frontend/web
sudo cp -R ./html/frontend/Grupo2-Cliente/dist/* ./html/frontend/web
sudo cp ./html/frontend/Grupo2-Cliente/dist/.* ./html/frontend/web
sudo rm -rf ./html/frontend/Grupo2-Cliente
if [ $parametro = "preproduccion" ] || [ $parametro = "Preproduccion" ] || [ $parametro = "PREPRODUCCION" ]; then
    sudo sudo docker container run -d --name veganfood_frontend -v /opt/veganfood/html/frontend/web:/usr/local/apache2/htdocs -p 10320:80 httpd:2.4.41
elif [ $parametro = "produccion" ] || [ $parametro = "produccion" ] || [ $parametro = "PRODUCCION" ]; then
    sudo sudo docker container run -d --name veganfood_frontend -v /opt/veganfood/html/frontend/web:/usr/local/apache2/htdocs --expose 80 -e VIRTUAL_HOST=www.veganfood.pve2.fpmislata.com -e LETSENCRYPT_HOST=www.veganfood.pve2.fpmislata.com --net "nginx-net" httpd:2.4.41
fi
sudo docker exec -it veganfood_frontend sed -i "s/AllowOverride None/AllowOverride All/g" conf/httpd.conf
