#!usr/env/bin bash
parametro=$1
sh desplegarServidor.sh $parametro
echo "<---------------Desplegado backend--------------->"
sh desplegarMysql.sh
echo "<---------------Desplegada BD--------------->"

sh desplegarCliente.sh $parametro
echo "<---------------Desplegado frontend--------------->"
