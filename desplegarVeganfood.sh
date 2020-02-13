parametro=$1
rm -rf ./veganfood
git clone https://github.com/ToniEsteso/veganfood.git 
cd ./veganfood
mkdir ./html ./html/frontend ./html/backend ./mysql
sh desplegarTodo.sh $parametro