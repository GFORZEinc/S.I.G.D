<?php
	
	class UsuariosControlador {
		
		public function __construct(){
			require_once "MODELO/UsuariosModelo.php";
		}
		
		public function index(){
			
			
			$usuarios = new Usuarios_modelo();
			$data["titulo"] = "Usuarios Registrados";
			$data["usuarios"] = $usuarios->get_usuarios();
			
			require_once "VISTA/usuarios/usuarios.html";	
		}

		public function nuevo(){
			
			$data["titulo"] = "Registro de Usuarios";
			require_once "VISTA/usuarios/usuarios_nuevo.html";
		}

		public function guarda(){
			
			$ci = $_POST['ci'];
			$nombre = $_POST['nombre'];
			$apellido = $_POST['apellido'];
			$fecha_nac = $_POST['fecha_nac'];
			
			$usuarios = new Usuarios_modelo();
			$usuarios->insertar($ci, $nombre, $apellido, $fecha_nac);
			$data["titulo"] = "Ingresar Registro";
			$this->index();
		}

		public function modificar($ci){
			
			$usuarios = new Usuarios_modelo();
			
			$data["ci"] = $ci;
			$data["usuarios"] = $usuarios->get_usuario($ci);
			$data["titulo"] = "Registro Usuarios";
			require_once "VISTA/usuarios/usuarios_modificar.html";
		}
		
		public function actualizar(){

            $ci = $_POST['ci'];
			$nombre = $_POST['nombre'];
			$apellido = $_POST['apellido'];
			$fecha_nac = $_POST['fecha_nac'];

			$usuarios = new Usuarios_modelo();
			$usuarios->modificar($ci, $nombre, $apellido, $fecha_nac);
			$data["titulo"] = "Usuarios";
			$this->index();
		}
		
		public function eliminar($ci){
			
			$perros = new Usuarios_modelo();
			$perros->eliminar($ci);
			$data["titulo"] = "Usuarios";
			$this->index();
		}	

    }