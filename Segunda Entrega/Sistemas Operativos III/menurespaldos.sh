#!/bin/bash

clear

opc=0
fecha=$(date +%Y%m%d-%H-%M-%S-backup_bd)

function menu() {
	echo "MENU DE GESTIÓN DE RESPALDOS"
	echo "1 - Realizar un respaldo completo"
	echo "2 - Respaldar la estructura de la Base de Datos"
	echo "3 - Respaldar de manera remota"
	echo "4 - Restaurar Base de Datos"
	echo "5 - Realizar consulta personalizada"
	echo "6 - Salir"
}

function respaldo_completo () {
	echo "Ingrse el nobre de la Base de Datos: "
	read nomb
	nombre=$(echo $nomb | tr '[:upper:]' '[:lower:]')
	echo "show database" | mysql -u root -p > bd.sql
	existe=$(cat bd.sql | grep -c $nombre)
	if [ $existe -ge 1]
	then
	mysqldump --opt --events --routines --triggers --default-character-set=utf8 -u root -p $nombre > $nombre.sql
	tar -czvf $fecha.tar.gz $nombre.sql
	mv $fecha.tar.gz /root/respaldos/bd/completa/
	rm $nombre.sql
	rm bd.sql
	else
	echo "No existe la Base de Datos, presione ENTER para continuar"
	read enter
	rm bd.sql
	fi
}

function respaldo_estructura() {
	echo "Ingrese el nombre de la Base de Datos: "
	read nomb
	nombre=$(echo $nomb | tr '[:upper:]' '[:lower:]')
	echo "show database" | mysql -u root -p > bd.sql
	existe=$(cat bd.sql | grep -c $nombre)
	if [ $existe -ge 1 ]
	then
	mysqldump -v --opt --no-data --default-character-set=utf8 -u root -p $nombre > $nombre.sql
	tar -czvf $fecha.tar.gz $nombre.sql
	mv $fecha.tar.gz /root/respaldos/bd/estructura
	rm $nombre.sql
	rm bd.sql
	else
	echo "No existe  la Base de Datos, presione ENTER para continuar"
	read enter
	rm bd.sql
	fi
}

function respaldo_remoto() {
	echo "Ingrese el nombre de la Base de Datos: "
	read nomb
	nombre=$(echo $nomb | tr '[:upper:]' '[:lower:]')
	echo "show database" | mysql - root -p > bd.sql
	existe=$(cat bd.sql | grep -c $nombre)
	if [ $existe -ge 1 ]
	then
	mysqldump -v --opt -h localhost -p 3306 --compress --events --routines --triggers --default-character-set=utf8 -u root -p $nombre > $nombre.sql
	tar -czvf $fecha.tar.gz $nombre.sql
	mv $fecha.tar.gz /root/respaldos/bd/completa
	rm $nombre.sql
	rm bd.sql
	else
	echo "No existe la Base de Datos, presione ENTER para continuar"
	read enter
	rm bd.sql
	fi
}

function consulta_personalizada() {
        echo "Ingrese el nombre de la Base de Datos: "
        read nomb
        nombre=$(echo $nomb | tr '[:upper:]' '[:lower:]')
        echo "show database" | mysql - root -p > bd.sql
        existe=$(cat bd.sql | grep -c $nombre)
        if [ $existe -ge 1 ]
	then
	echo "¿Que datos quieres ver?"
	echo "ADVERTENCIA: Si quieres ver todos los datos ingrese '*'(Asterisco)"
	read dato
	echo "Ingrese la tabla a ver: "
	read tabla
	echo "use $nombre; select $dato from $tabla" | mysql -u root -pgrupogforze
	else
	echo "No existe la Base de Datos"
	echo "Presione ENTER para continuar"
	fi
}

while [ $opc -ne 6 ]
	do
		menu
		echo "Ingrese una opcion: "
		read opc
		case $opc in
		1) respaldo_completo;;
		2) respaldo_estructura;;
		3) respaldo_remoto;;
		4) restaurar_bd;;
		5) consulta_personalizada;;
		6) echo "Adios" ; break;;
		*) echo "Opcion no valida"; read pausa;;
	esac
done
