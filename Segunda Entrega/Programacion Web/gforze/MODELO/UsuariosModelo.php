<?php

class Usuarios_modelo
{
//Declaramos dos atributos para la conexión
    private $db;
    private $usuarios;

    public function __construct()
    {//Operador de Resolución de Ámbito :: hacemos referecia a la clase externa Conectar
        $this->db = Conectar::conexion();
     //Inicializo perros como un array vacio.
        $this->usuarios = array();
    }
    // Método que devuelve la información de la tabla.

    public function get_usuarios()
    {
        //Consulta sql para seleccionar t
        $sql = "SELECT * FROM usuario";
        $resultado = $this->db->query($sql);
        //Para obtener una fila de resultado como un array asociativo
        while ($row = $resultado->fetch_assoc()) {
            $this->usuarios[] = $row;
        }
        return $this->usuarios;
    }

    public function insertar($ci, $nombre, $apellido, $fecha_nac){
			
        $resultado = $this->db->query("INSERT INTO usuario (ci, nombre , apellido, fecha_nac) VALUES ('$ci', '$nombre', '$apellido', '$fecha_nac')");
        
    }
   
    public function modificar($ci, $nombre, $apellido, $fecha_nac){
			
        $resultado = $this->db->query("UPDATE usuario SET nombre='$nombre', apellido='$apellido', fecha_nac='$fecha_nac' WHERE ci= '$ci'");			
    }
    
    public function eliminar($ci){
        
        $resultado = $this->db->query("DELETE FROM usuario WHERE ci = '$ci'");
        
    }
    
    public function get_usuario($ci)
    {
        $sql = "SELECT * FROM usuario WHERE ci='$ci' LIMIT 1";
        $resultado = $this->db->query($sql);
        $row = $resultado->fetch_assoc();

        return $row;
    }
} 


?>