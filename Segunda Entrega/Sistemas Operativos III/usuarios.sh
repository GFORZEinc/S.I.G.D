#!/bin/bash
#variables globales******
opc=0
#************************
clear

function menu(){
	echo "MENU"
	echo "1 - Agregar Usuario"
	echo "2 - Listar Usuarios"
	echo "3 - Buscar Usuarios"
	echo "4 - Borrar Usuarios"
	echo "5 - Bloquear Usuario"
	echo "6 - Desbloquear Usaurio"
	echo "7 - Cambiar Contraseña"
	echo "0 - Volver"
	echo "Ingrese una opcion: "

}

function altaUsuarios(){
	clear
	echo "Ingrese el Nombre de Usuario: "
	read nombre
	echo "En que grupo lo quieres guardar"
	read grupo
	existeGrupo=$(cat /etc/group | grep -c $grupo)
	existeUsuario=$(cat /etc/passwd | grep -c $nombre)
	if [ $existeUsuario -eq 1  $existeGrupo -eq 0]; then
		echo "El Usuario Existe"
		echo "El Grupo no Existe, presione ENTER para continuar"
		read a
	else
		useradd -g $grupo -d /home $nombre -m -s/bin/bash
		echo "Usuario Creado en el Grupo $grupo"
		echo "Presione ENTER para continuar"
		read a
		fi
}

function bajaUsuario() {
	clear
        echo "Ingrese el Usuario que desea Eliminar: "
        read nombre
        existeUsuario=$(cat /etc/passwd | grep -c $nombre)
        if [ $existeUsuario -eq 1 ]; then
		userdel -r $nombre
                echo "Usuario Eliminado"
                echo "Presione ENTER para continuar"
                read a

        else
		echo "Usuario no Existe"
		echo "Presione ENTER para continuar"
		read a
	fi
}



function listarUsuarios(){
	clear
	echo "LISTA DE USUARIOS"
	cut -d ":" -f 1 /etc/passwd
	echo "Presione ENTER para continuar"
	read a
}



function bloquearUsuario(){
	clear
	echo "Ingrese el Usuario que desea Bloquear: "
	read bloqueo
	existeUsuario=$(cat /etc/passwd | grep -c $bloqueo)
	if [ $existeUsuario -eq 1 ]; then
		usermod -L $bloqueo
                echo "Usuario Bloqueado"
                echo "Presione ENTER para continuar"
                read a

	else
		echo "Usuario no existe"
		echo "Presione ENTER para continuar"
		read a
	fi
}

function desbloquearUsuario(){
	clear
        echo "Ingrese el Usuario que desea Bloquear: "
        read desbloqueo
        existeUsuario=$(cat /etc/passwd | grep -c $desbloqueo)
        if [ $existeUsuario -eq 1 ]; then
                usermod -u $desbloqueo
                echo "Usuario Desbloqueado"
                echo "Presione ENTER para continuar"
                read a

        else
                echo "Usuario no existe"
                echo "Presione ENTER para continuar"
                read a
        fi
}

function cambiarContra (){
	clear
	echo "Ingrese el Nombre de Usuario: "
	read nombre
	existeUsuario=$(cat /etc/passwd | grep -c $nombre)
	if [ existeUsuario -eq 1 ]; then
		passwd $nombre
	else
		echo "El Usuario no existe, presione ENTER para continuar"
		read a
	fi
}

function buscarUsuarios(){
clear
        echo "Ingrese el Nombre de Usuario: "
        read nombre
        existeUsuario=$(cat /etc/passwd | grep -c $nombre)
        if [ $existeUsuario -eq 1 ]; then
                echo "El Usuario Existe"
                grep $nombre /etc/passwd
		echo "Presione ENTER para continuar"
		read a	
	else
		echo "El Usuario no Existe"
		echo "Presione ENTER para contianuar"
		read a
	fi
}

while [ $opc -ne 8 ];
do
	menu
	read opc
	case $opc in
		1)
			echo "AGREGAR USUARIO";
			altaUsuarios;;
		2)
			echo "LISTA DE USUARIOS";
			listarUsuarios;;
		3)
			echo "BUSCAR USUARIOS";
			buscarUsuarios;;
		4)
			echo "ELIMINAR USUARIO";
			bajaUsuario;;
		5)
			echo "BLOQUEAR USUARIO";
			bloquearUsuario;;
		6)
			echo "DESBLOQUEAR USUARIO";
			desbloquearUsuario;;
		7)
			echo "CAMBIAR CONTRASEÑA";
			cambiarContra;;
		0)
			echo "Hasta Pronto"; break;;
		*)
			echo "Ingreso una opcion INCORRECTA";;
	esac
done
