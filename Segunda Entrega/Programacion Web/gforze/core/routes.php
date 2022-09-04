<?php
	//Función para cargar el controlador recibe un string y devuelve unas instacia del controlar
	function cargarControlador(String $controlador): object{
		//ucwords convierte en mayuscula el primer caracter de la cadena.
		$nombreControlador = ucwords($controlador)."CONTROLADOR";
		$archivoControlador = 'CONTROLADOR/'.ucwords($controlador).'.php';
		//Controlo si el archivo no exite cargue por defecto el controlador principal
		if(!is_file($archivoControlador)){
			
			$archivoControlador= 'CONTROLADOR/'.CONTROLADOR_PRINCIPAL.'.php';
			
		}
		require_once $archivoControlador;
		$control = new $nombreControlador();
		return $control;
	}
	
	function cargarAccion($controlador, $accion, $ci = null){
		/*La method_exists() función devuelve true si un objeto o una clase tiene un método específico. De lo contrario, vuelve false.*/
		if(isset($accion) && method_exists($controlador, $accion)){
			if($ci == null){
				$controlador->$accion();
				} else {
					$controlador->$accion($ci);
			}
			} else {
				$controlador->ACCION_PRINCIPAL();
		}	
	}
?>