#!/bin/bash

clear

opc=0
fecha=$(date +%Y/%m/%d-%H:%M:%S-backup_bd)

function menu() {
	clear
	echo "MENU DE GESTIÓN DE RESPALDOS"
	echo "1 - Realizar un respaldo completo"
	echo "2 - Respaldar la estructura de la Base de Datos"
	echo "3 - Respaldar de manera remota"
	echo "4 - Restaurar Base de Datos"
	echo "5 - Realizar consulta personalizada"
	echo "6 - Salir"
}

function respaldo_completo () {
	clear
	echo "Ingrese el nombre de la Base de Datos: "
	read nomb
	nombre=$(echo $nomb | tr '[:upper:]' '[:lower:]')
	echo "show databases;" | mysql -h 192.168.2.195  -u dvallejos -p > bd.sql
	existe=$(cat bd.sql | grep -c $nombre)
	if [ $existe -ge 1 ]
	then
		mysqldump --opt --events --routines --triggers --default-character-set=utf8 -h 192.168.2.195 -u dvallejos -p54935465 $nombre > $nombre.sql
		mv $fecha /root/respaldos/bd/completa/
		echo "$fecha Se ah realizado el respaldo completo de la base de datos $nombre correctamente" >> /root/logs_propios/respaldos.txt
	else
		echo "$fecha No se ah pudo realizar el respaldo completo de la base de datos $nombre" >> /root/logs_propios/respaldos.txt
		echo "No existe la Base de Datos, presione ENTER para continuar"
		read enter
		rm bd.sql
	fi
}

function respaldo_estructura() {
	clear
	echo "Ingrese el nombre de la Base de Datos: "
	read nomb
	nombre=$(echo $nomb | tr '[:upper:]' '[:lower:]')
	echo "show databases;" | mysql -h 192.168.2.195 -u dvallejos -p > bd.sql
	existe=$(cat bd.sql | grep -c $nombre)
	if [ $existe -ge 1 ]
	then
		mysqldump -h 192.168.2.195 -v --opt --no-data --default-character-set=utf8 -u dvallejos -p54935465 $nombre > $nombre.sql
		mv $fecha.tar.gz /root/respaldos/bd/estructura/
		echo "$fecha Se ah realizado el respaldo de la estructura de la base de datos $nombre correctamente" >> /root/logs_propios/respaldos.txt
	else
		echo "$fecha No se ah pudo realizar el respaldo de la estructura de la base de datos $nombre" >> /root/logs_propios/respaldos.txt
		echo "No existe  la Base de Datos, presione ENTER para continuar"
		read enter
		rm bd.sql
	fi
}

function respaldo_remoto() {
	clear
	echo "Ingrese el nombre de la Base de Datos: "
	read nomb
	nombre=$(echo $nomb | tr '[:upper:]' '[:lower:]')
	echo "show databases;" | mysql -h 192.168.2.195 -u dvallejos -p > bd.sql
	existe=$(cat bd.sql | grep -c $nombre)
	if [ $existe -ge 1 ]
	then
		mysqldump -v --opt -h 192.168.2.195 -p 3306 --compress --events --routines --triggers --default-character-set=utf8 -u dvallejos -p54935465 $nombre > $nombre.sql
		mv $fecha.tar.gz /root/respaldos/bd/completa/
		echo "$fecha Se ah realizado el respaldo remoto de la base de datos $nombre correctamente" >> /root/logs_propios/respaldos.txt
	else
		echo "$fecha No se ah pudo realizar el respaldo remoto de la base de datos $nombre" >> /root/logs_propios/respaldos.txt
		echo "No existe la Base de Datos, presione ENTER para continuar"
		read enter
		rm bd.sql
	fi
}

function restaurar_database (){
	clear
	echo "Ingrese el nombre de la base de datos: "
	read nomb
	nombre=$(echo $nomb | tr '[:upper:]' '[:lower:]')
}

function consulta_personalizada() {
	clear
        echo "Ingrese el nombre de la Base de Datos: "
        read nomb
        nombre=$(echo $nomb | tr '[:upper:]' '[:lower:]')
        echo "show databases;" | mysql -h 192.168.2.195 -u dvallejos -p > bd.sql
        existe=$(cat bd.sql | grep -c $nombre)
        if [ $existe -ge 1 ]
	then
		echo "¿Que datos quieres ver?"
		echo "ADVERTENCIA: Si quieres ver todos los datos ingrese '*'(Asterisco)"
		read dato
		echo "Ingrese la tabla a ver: "
		read tabla
		echo "use $nombre; select $dato from $tabla" | mysql -h 192.168.2.195 -u dvallejos -p54935465
		echo "$fecha Se ah echo la consulta de $dato de la tabla $tabla de la base de datos $nombre correctamente" >> /root/logs_propios/consultas.txt
		read a
	else
		echo "$fecha No existe la Base de Datos $nombre" >> /root/logs_propios/consultas.txt
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
