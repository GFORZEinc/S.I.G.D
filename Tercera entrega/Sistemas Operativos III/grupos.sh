#!/bin/bash
opc=0

#Funciones****************************
function menu_grupos(){
  clear
  echo "MENÚ DE GESTIÓN DE GRUPOS"
  echo "1 - Agregar grupo"
  echo "2 - Eliminar grupo"
  echo "3 - Listar grupos del sistema"
  echo "4 - Buscar un grupo"
  echo "0 - Salir"
  
}

function altaGrupo() {
        clear
        echo "Ingrese el Nombre del Grupo (en minusculas): "
        read grupo
	group=$(echo $grupo | tr [:upper:] [:lower:])
        existeGrupo=$(cat /etc/group | grep -c $group)
        if [ $existeGrupo -eq 1 ]; then
                echo $(date +%Y/%m/%d-%H:%M:%S) "El Grupo $grupo ya Existe" >> /root/logs_propios/grupos.txt
		echo "El grupo $grupo ya Existe"
		echo "Presione ENTER para continuar"
		read a
        else
                groupadd -f $grupo
                echo $(date +%Y/%m/%d-%H:%M:%S) "El grupo $grupo ah sido Agregado" >> /root/logs_propios/grupos.txt
		echo "El grupo $grupo ah sido Agregado"
                echo "Presione ENTER para continuar"
                read a
        fi
}

function bajaGrupo() {
        clear
        echo "Ingrese el Grupo que desea Eliminar (en minusculas): "
        read grupo
	group=$(echo $grupo | tr [:upper:] [:lower:])
        existeGrupo=$(cat /etc/group | grep -c $group)
        if [ $existeGrupo -eq 1 ]; then
                groupdel -f $grupo
		echo $(date +%Y/%m/%d-%H:%M:%S) "El grupo $grupo ah sido Eliminado" >> /root/logs_propios/grupos.txt
		echo "El grupo $grupo ah sido Eliminado"
		echo "Presione ENTER para continuar"
		read a
	else
		echo $(date +%Y/%m/%d-%H:%M:%S) "El grupo $grupo no existe" >> /root/logs_propios/grupos.txt
		echo "El grupo $grupo no existe"
                echo "Presione ENTER para continuar"
		read a
	fi
}

function listarGrupos(){
        clear
        echo "LISTA DE GRUPOS"
        cut -d ":" -f 1 /etc/group
	echo "Presione ENTER para continuar"
	read
}

function buscarGrupos(){
clear
        echo "Ingrese el Nombre de Grupo (en minusculas): "
        read grupo
	group=$(echo $grupo | tr [:upper:] [:lower:])
        existeGrupo=$(cat /etc/group | grep -c $group)
        if [ $existeGrupo -eq 1 ]; then
                echo $(date +%Y/%m/%d-%H:%M:%S) "El Grupo $grupo Existe" >> /root/logs_propios/grupos.txt
		echo "El grupo $grupo Existe"
                grep $grupo /etc/group
                echo "Presione ENTER para continuar"
                read a
        else
                echo $(date +%Y/%m/%d-%H:%M:%S) "El Grupo $grupo no Existe" >> /root/logs_propios/usuarios.txt
		echo "El grupo $grupo no Existe"
                echo "Presione ENTER para contianuar"
                read a
        fi
}




while [ $opc -ne 5 ]
    do
        menu_grupos
        echo "Ingrese una opción: "
        read opc
        case $opc in
            1) 
		echo "AGREGAR GRUPO";
		altaGrupo;;
            2) 
		echo "ELIMINAR GRUPO";
		bajaGrupo;;
            3)
		echo "LISTAR GRUPO";
		listarGrupos;;
	    4)
		echo "BUSCAR GRUPO";
		buscarGrupos;;
            0)
		 echo "Hasta luego" ; break ;;
            *) echo "Opción no valida" ; read pausa ;;
        esac
    done
