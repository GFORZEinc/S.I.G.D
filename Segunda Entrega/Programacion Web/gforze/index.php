<?php
require_once "config/bd.php";
require_once "CONTROLADOR/Usuarios.php";
require_once "config/config.php";
require_once "core/routes.php";

//La función isset() nos permite evaluar si una variable está definida o no
	
	if(isset($_GET['c'])){
		
		$controlador = cargarControlador($_GET['c']);
		
		if(isset($_GET['a'])){
			if(isset($_GET['ci'])){
				cargarAccion($controlador, $_GET['a'], $_GET['ci']);
				} else {
				cargarAccion($controlador, $_GET['a']);
			}
			} else {
			cargarAccion($controlador, ACCION_PRINCIPAL);
		}
		
		} else {
		
		$controlador = cargarControlador(CONTROLADOR_PRINCIPAL);
		$accionTmp = ACCION_PRINCIPAL;
		$controlador->$accionTmp();
	}
?>