parametro=$1
rm -rf /opt/veganfood
mkdir /opt/veganfood
git clone https://github.com/ToniEsteso/Veganfood.git /opt/veganfood
cd ./veganfood
mkdir ./html ./html/frontend ./html/backend ./mysql
sh desplegarTodo.sh parametro