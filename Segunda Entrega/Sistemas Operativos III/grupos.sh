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
        echo "Ingrese el Nombre del Grupo: "
        read grupo
        existeGrupo=$(cat /etc/group | grep -c $grupo)
        if [ $existeGrupo -eq 1 ]; then
                echo "El Grupo que Acaba de Ingresar ya Existe"
        else
                groupadd -f $grupo
                echo "Grupo Agregado"
                echo "Presione ENTER para continuar"
                read a
        fi
}

function bajaGrupo() {
        clear
        echo "Ingrese el Grupo que desea Eliminar: "
        read grupo
        existeGrupo=$(cat /etc/group | grep -c $grupo)
        if [ $existeGrupo -eq 1 ]; then
                groupdel -f $grupo
		echo "Grupo Eliminado"
		echo "Presione ENTER para continuar"
		read a
	else
		echo "El Grupo no existe"
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
        echo "Ingrese el Nombre de Grupo: "
        read grupo
        existeGrupo=$(cat /etc/group | grep -c $group)
        if [ $existeGrupo -eq 1 ]; then
                echo "El Grupo Existe"
                grep $grupo /etc/group
                echo "Presione ENTER para continuar"
                read a
        else
                echo "El Grupo no Existe"
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
