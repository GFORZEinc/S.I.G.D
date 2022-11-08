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
	echo "Ingrese el Nombre de Usuario (en minusculas): "
	read nombre
	user=$(echo $nombre | tr [:upper:] [:lower:])
	existeUsuario=$(cat /etc/passwd | grep -c $user)
	if [ $existeUsuario -eq 1 ]; then
		echo "El Usuario Existe"
		echo $(date +%Y/%m/%d-%H:%M:%S) "Se trato de crear un usuario con el nombre $nombre" >> /root/logs_propios/usuarios.txt
		echo "Se trato de crear un usuario con el nombre $nombre"
		echo "Presione ENTER para conitanuar"
		read a
	else
		echo "Ingrese el grupo (en minusculas): "
		read grupo
		group=$(echo $grupo | tr [:upper:] [:lower:])
		existeGrupo=$(cat /etc/group | grep -c $grupo)
		if [ $existeGrupo -eq 1 ]; then
			useradd -g $group -d /home/$user -m -s /bin/bash $user
			echo $(date +%Y/%m/%d-%H:%M:%S) "El usuario $nombre ah sido creado en el Grupo $grupo" >> /root/logs_propios/usuarios.txt
			echo "El usuario $nombre ah sido creado en el grupo $grupo"
			echo "Presione ENTER para continuar"
			read a
		else
			echo "El grupo $grupo no existe"
			read a
		fi
	fi
}

function bajaUsuario() {
	clear
        echo "Ingrese el Usuario que desea Eliminar (en minusculas): "
        read nombre
        existeUsuario=$(cat /etc/passwd | grep -c $nombre)
        if [ $existeUsuario -eq 1 ]; then
		userdel -r -f $nombre
                echo $(date +%Y/%m/%d-%H:%M:%S) "El usuario $nombre ah sido Eliminado" >> /root/logs_propios/usuarios.txt
		echo "El usuario $nombre ah sido Elimindado"
                echo "Presione ENTER para continuar"
                read a

        else
		echo $(date +%Y/%m/%d-%H:%M:%S) "El usuario $nombre no Existe" >> /root/logs_propios/usuarios.txt
		echo "El usuario $nombre no Existe"
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
	echo "Ingrese el Usuario que desea Bloquear (en minusculas): "
	read bloqueo
	existeUsuario=$(cat /etc/passwd | grep -c $bloqueo)
	if [ $existeUsuario -eq 1 ]; then
		usermod -L $bloqueo
                echo $(date +%Y/%m/%d-%H:%M:%S) "El usuario $bloqueo ah sido bloqueado" >> /root/logs_propios/usuarios.txt
		echo "El usuario $bloqueo ah sido bloqueado"                
		echo "Presione ENTER para continuar"
                read a

	else
		echo $(date +%Y/%m/%d-%H:%M:%S) "El usuario $bloqueo no existe" >> /root/logs_propios/usuarios.txt
		echp "El usuario $bloqueo no existe"
		echo "Presione ENTER para continuar"
		read a
	fi
}

function desbloquearUsuario(){
	clear
        echo "Ingrese el Usuario que desea Bloquear (en minusculas): "
        read desbloqueo
        existeUsuario=$(cat /etc/passwd | grep -c $desbloqueo)
        if [ $existeUsuario -eq 1 ]; then
                usermod -u $desbloqueo
                echo $(date +%Y/%m/%d-%H:%M:%S) "El usuario $desbloqueo Desbloqueado" >> /root/logs_propios/usuarios.txt
		echo "El usuario $desbloqueo ah sido Desbloqueado"
                echo "Presione ENTER para continuar"
                read a

        else
                echo $(date +%Y/%m/%d-%H:%M:%S) "El usuario $desbloqueo no existe" >> /root/logs_propios/usuarios.txt
		echo "El usuario $desbloqueo no existe"
                echo "Presione ENTER para continuar"
                read a
        fi
}

function cambiarContra (){
	clear
	echo "Ingrese el Nombre de Usuario (en minusculas): "
	read nombre
	existeUsuario=$(cat /etc/passwd | grep -c $nombre)
	if [ $existeUsuario -eq 1 ]; then
		passwd $nombre
		echo $(date +%Y/%m/%d-%H:%M:%S) "Su contraseña se ah cambiado correctamente" >> /root/logs_propios/usuarios.txt
		echo "Su contraseña se ah cambiado correctamente"
		read a	
	else
		echo $(date +%Y/%m/%d-%H:%M:%S) "El Usuario $nombre no existe" >> /root/logs_propios/usuarios.txt 
		echo "El usuario %nombre no existe"
		echo "Presione ENTER para continuar"
		read a
	fi
}

function buscarUsuarios(){
clear
        echo "Ingrese el Nombre de Usuario (en minusculas): "
        read nombre
        existeUsuario=$(cat /etc/passwd | grep -c $nombre)
        if [ $existeUsuario -eq 1 ]; then
                echo $(date +%Y/%m/%d-%H:%M:%S) "El Usuario $nombre Existe" >> /root/logs_propios/usuarios.txt
		echo "El usuario $nombre Existe" 
                grep $nombre /etc/passwd
		echo "Presione ENTER para continuar"
		read a	
	else
		echo $(date +%Y/%m/%d-%H:%M:%S) "El usuario $nombre no Existe" >> /root/logs_propios/usuarios.txt
		echo "El usuarios $nombre no Existe"
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
