create database gforze;
use gforze;

  /*========================*/
 /* CREACION DE LAS TABLAS */
/*========================*/
CREATE TABLE Persona (
CI INT NOT NULL,
nombre CHAR (10),
apellido CHAR (15),
fech_nac date,
correo CHAR (20),
funcion CHAR (20),
PRIMARY KEY (ci));

create table Analista(
CI INT NOT NULL,
constraint fk_CIAnalista foreign key (CI) references Persona (CI) ,
PRIMARY KEY (CI)
);

create table Arbitro(
CI INT,
constraint fk_CIArbitro foreign key (CI) references Persona (CI) ,
PRIMARY KEY (CI)
);

create table Administrador(
CI INT,
constraint fk_CIAdministrador foreign key (CI) references Persona (CI), 
PRIMARY KEY (CI)
);

create table Jugador(
CI INT,
constraint fk_CIJugador foreign key (CI) references Persona (CI) , 
PRIMARY KEY (CI)
);

create table Entrenador(
CI INT,
constraint fk_CIEntrenador foreign key (CI) references Persona (CI) , 
PRIMARY KEY (CI)
);

create table Administrativo(
CI INT,
constraint fk_CIAdministrativo foreign key (CI) references Persona (CI) , 
PRIMARY KEY (CI)
);

create table Realiza(
CI INT,
constraint fk_CIRealiza foreign key (CI) references Administrativo (CI) 
);

create table Ficha (
Id_Ficha int not null auto_increment,
Fecha_Nac date,
Permisos char,
Ficha_Medica char,
PRIMARY KEY (Id_Ficha)
);

create table Deporte(
Id_Deporte INT not null auto_increment,
Nombre char,
Reglamento char,
PRIMARY KEY (Id_Deporte)
);

create table Equipo(
Id_Equipo INT not null auto_increment,
Categoria INT,
Nombre char,
Dueño char,
Cantidad char,
PRIMARY KEY (Id_Equipo)
);

create table Torneo(
Id_Torneo INT not null auto_increment,
Nombre char,
Inicio date,
Final date,
Dia_Juego date,
PRIMARY KEY (Id_Torneo)
);

create table Partido(
Id_Partido INT not null auto_increment,
Fecha_Hora datetime,
Ubicacion char,
Resultado INT,
PRIMARY KEY (Id_Partido)
);

create table Incidencias(
Id_Incidencias INT not null auto_increment,
Fecha_Hora datetime,
Valor char,
PRIMARY KEY (Id_Incidencias)
);

create table Tipo_Incidencias(
Id_Tipo INT not null auto_increment,
Nombre char,
PRIMARY KEY (Id_Tipo)
);

create table Crea(
CI INT NOT NULL,
Id_Deporte int NOT NULL,
constraint fk_CICrea foreign key (CI) references Administrador (CI),
constraint fk_IdDeporteCrea foreign key (Id_Deporte) references Deporte (Id_Deporte) 
);

create table Pertenece(
CI INT NOT NULL,
Id_Equipo INT NOT NULL,
Posicion char,
constraint fk_CIPertenece foreign key (CI) references Jugador (CI),
constraint fk_IdEquipoPertenece foreign key (Id_Equipo) references Equipo (Id_Equipo) 
);

create table Dirige(
CI INT NOT NULL,
Id_Equipo INT NOT NULL,
constraint fk_CIDirige foreign key (CI) references Entrenador (CI),
constraint fk_IdEquipoDirige foreign key (Id_Equipo) references Equipo (Id_Equipo) 
);

create table Crean(
CI INT NOT NULL,
Id_Torneo INT NOT NULL,
constraint fk_CICrean foreign key (CI) references Administrativo (CI) ,
constraint fk_IdTorneoCrean foreign key (Id_Torneo) references Torneo (Id_Torneo) 
);

create table Entran(
Id_Deporte INT NOT NULL,
Id_Equipo INT NOT NULL,
constraint fk_IdDeporteEntran foreign key (Id_Deporte) references Deporte (Id_Deporte),
constraint fk_IdEquipoEntran foreign key (Id_Equipo) references Equipo (Id_Equipo) 
);

create table Participan(
Id_Torneo INT NOT NULL,
Id_Equipo INT NOT NULL,
constraint fk_IdTorneoParticipan foreign key (Id_Torneo) references Torneo (Id_Torneo),
constraint fk_IdEquipoParticipan foreign key (Id_Equipo) references Equipo (Id_Equipo) 
);

create table Juegan(
Id_Equipo INT NOT NULL,
Id_Partido INT NOT NULL,
constraint fk_IdEquipoJuegan foreign key (Id_Equipo) references Equipo (Id_Equipo),
constraint fk_IdPartidoJuegan foreign key (Id_Partido) references Partido (Id_Partido) 
);

create table Arbitan(
CI INT NOT NULL,
Id_Equipo INT NOT NULL,
constraint fk_CIArbitran foreign key (CI) references Arbitro (CI),
constraint fk_IdEquipoArbitran foreign key (Id_Equipo) references Equipo (Id_Equipo) 
);

create table Realizan(
Id_Equipo INT NOT NULL,
Id_Partido INT NOT NULL,
constraint fk_IdEquipoRealizan foreign key (Id_Equipo) references Equipo (Id_Equipo) ,
constraint fk_IdPartidoRealizan foreign key (Id_Partido) references Partido (Id_Partido) 
);

create table Validan(
CI INT NOT NULL,
Id_Incidencias INT NOT NULL,
constraint fk_CIValidan foreign key (CI) references Arbitro (CI),
constraint fk_IdIncidenciasValidan foreign key (Id_Incidencias) references Incidencias (Id_Incidencias) 
);

create table Registro(
Id_Incidencias INT NOT NULL,
CI INT NOT NULL,
Id_Equipo INT NOT NULL,
constraint fk_IdEquipoRegistro foreign key (Id_Equipo) references Equipo (Id_Equipo),
constraint fk_CIRegistro foreign key (CI) references Jugador (CI),
constraint fk_IdIncidenciasRegistro foreign key (Id_Incidencias) references Incidencias (Id_Incidencias) 
);

create table Segun(
Id_Deporte INT NOT NULL,
Id_Tipo INT NOT NULL,
constraint fk_IdDeporteSegun foreign key (Id_Deporte) references Deporte (Id_Deporte),
constraint fk_IdTipoSegun foreign key (Id_Tipo) references Tipo_Incidencias (Id_Tipo) 
);

create table Registran(
CI INT NOT NULL,
Id_Incidencias INT NOT NULL,
constraint fk_CIRegistran foreign key (CI) references Analista (CI),
constraint fk_IdIncidenciasRegistran foreign key (Id_Incidencias) references Incidencias (Id_Incidencias) 
);

create table Tienen(
Id_Incidencias INT NOT NULL,
Id_Partido INT NOT NULL,
constraint fk_IdIncidenciasTienen foreign key (Id_Incidencias) references Incidencias (Id_Incidencias)  ,
constraint fk_IdPartidoTienen foreign key (Id_Partido) references Partido (Id_Partido)
);

create table Tiene(
Id_Incidencias INT NOT NULL,
Id_Tipo INT NOT NULL,
constraint fk_IdIncidenciasTiene foreign key (Id_Incidencias) references Incidencias (Id_Incidencias),
constraint fk_IdTipoTiene foreign key (Id_Tipo) references Tipo_Incidencias (Id_Tipo)
);



























