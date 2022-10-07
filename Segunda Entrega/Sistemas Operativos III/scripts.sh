#!/bin/bash

opc=0

clear

function menu(){
	echo "MENU"
	echo "1 - Menu de Respaldos"
	echo "2 - Menu de Usuarios"
	echo "3 - Menu de Grupos"
	echo "0 - Salir"
	echo "Ingrese una opcion: "
}


function llamarrespaldos(){
	bash menurespaldos.sh
}

function llamarusuarios(){
	bash usuarios.sh
}

function llamargrupos(){
	bash grupos.sh
}

while [ $opc -ne 3 ];
do
	menu
	read opc
	case $opc in
		1)
			echo "MENU DE RESPALDOS";
			llamarrespaldos;;
		2)
			echo "MENU DE USUARIOS";
			llamarusuarios;;
		3)
			echo "MENU DE GRUPOS";
			llamargrupos;;
		0)
			echo "Hasta Luego"; break;;
		*)
			echo "Esa opcion no existe";;
	esac
done
