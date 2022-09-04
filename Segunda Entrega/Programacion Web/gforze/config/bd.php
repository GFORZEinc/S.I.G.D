<?php
//Creamos una conexión de BD
class Conectar
{

    public static function conexion()
    {

        $servername = "127.0.0.1";
        $username = "root";
        $password = "";
        $database = "registro_usuarios";

        //Parametro de Entrada: Servidor, usuario,pass, base de datos.
        $conexion = new mysqli($servername, $username, $password, $database);
        //Verificamos la conexión
        if ($conexion->connect_error) {
            printf("Conexión fallida: %s\n", $conexion->connect_error);
            exit();
        }

        return $conexion;

    }
}
