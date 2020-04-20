#en este archivo vamos a agregar los datos por defecto, como los siguientes:

/**
	Departamentos -> ya
    Municipios -> ya
    Permisos ->ya
    Roles -> ya
    Autorizacion -> ya
    Categorías -> ya
*/

# definicion de procedimientos almacenados para que sea mas facil la insercion de valores por defecto.
use main;
DELIMITER /
CREATE PROCEDURE proc_roles()
BEGIN
	INSERT INTO rol (nombre)
    VALUES 
		("Vendedor"),
        ("Bodeguero"),#un encargado de bodega tambien tiene los mismos permisos que un bodeguero
        ("Repartidor"),
        ("Administrador"),
        ("Encargado de Sede"),
        ("Encargado de bodega")
        ;
	
	INSERT INTO  permiso (nombre)
    VALUES 
		("Registro de clientes"),
        ("Registro de ventas"),
        ("Visualizar reporte de ventas"),
        ("Actualizar inventario"),
        ("Solicitar transferencia"),
        ("Visualizar/Aceptar órdenes de transferencia internas"),
        ("Visualizar/Aceptar órdenes de transferencia externas"),
        ("Visualizar/Entregar órdenes de venta"),
        ("Visualizar/Entregar órdenes de transferencia"),
        ("Registro de sedes"),
        ("Registro de usuarios"),
        ("Registro de bodegas")
        ;
END//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE proc_default_values()
BEGIN
	call proc_default_deptos();
    call proc_default_municipios();
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE proc_default_deptos()
BEGIN
	INSERT INTO departamento (nombre)
    VALUES 
		("Alta Verapaz"),
        ("Baja Verapaz"),
        ("Chimaltenango"),
        ("Chiquimula"),
        ("El Progreso"),
        ("Escuintla"),
        ("Guatemala"),
        ("Huehuetenango"),
        ("Izabal"),
        ("Jalapa"),
        ("Jutiapa"),
        ("Petén"),
        ("Quetzaltenango"),
        ("Quiché"),
        ("Retalhuleu"),
        ("Sacatepéquez"),
        ("San Marcos"),
        ("Santa Rosa"),
        ("Sololá"),
        ("Suchitepéquez"),
        ("Totonicapán"),
        ("Zacapa")
        ;
END//
DELIMITER ;

use main;
DELIMITER //
CREATE PROCEDURE proc_default_municipios()
BEGIN
	INSERT INTO municipio (nombre, id_dep)
    VALUES ("Cobán",1),("San Pedro Carchá",1),("San Juan Chamelco",1),("San Cristóbal Verapaz",1),("Tactic",1),("Tucuru",1),("Tamahú",1),("Panzos",1),("Senahú",1),("Cahabón",1),("Lanquín",1),
    ("Chahal",1),("Fray Bartolomé de las Casas",1),("Chisec",1),("Santa Cruz Verapaz",1),("Santa Catarina La Tinta",1),("Raxruhá",1),
    
    ("Cubulco", 2),("Santa Cruz el Chol", 2),("Granados", 2),("Purulhá", 2),
    ("Rabinal", 2),("Salamá", 2),("San Miguel Chicaj", 2),("San Jerónimo", 2),
    
    ("Chimaltenango",3),("San José Poaquil",3),("San Martín Jilotepeque",3),("San Juan Comalapa",3),
    ("Santa Apolonia",3),("Tecpán Guatemala",3),("Patzún",3),("Pochuta",3),
    ("Patzicía",3),("Santa Cruz Balanyá",3),("Acatenango",3),("San Pedro Yepocapa",3),
    ("San Andrés Itzapa",3),("Parramos",3),("Zaragoza",3),("El Tejar",3),
    
    ("Chiquimula",4),("Jocotán",4),("Esquipulas",4),("Camotán",4),
    ("Quetzaltepeque",4),("Olopa",4),("Ipala",4),("San Juan Ermita",4),
    ("Concepción Las Minas",4),("San Jacinto",4),("San José la Arada",4),
    
    ("El Jícaro", 5),("Guastatoya", 5),("Morazán", 5),("Sanarate", 5),
    ("Sansare", 5),("San Agustín Acasagustlán", 5),("San Antonio La Paz", 5),("San Cristóbal Acasagustlán", 5),
    
    
    ("Escuintla",6),("Guanagazapa",6),("Iztapa",6),("La Democracia",6),
    ("La Gomera",6),("Masagua",6),("Nueva Concepción",6),("Palín",6),
    ("San José",6),("San Vicente Pacaya",6),("Santa Lucía Cotzumalguapa",6),("Sipacate",6),
    ("Siquinalá",6),("Tiquisate",6),
    
    ("Guatemala", 7),("Villa Nueva", 7),("Mixco", 7),("Santa Catarina Pinula", 7),
    ("San José Pinula", 7),("San José del Golfo", 7),("Palencia", 7),("Chinautla", 7),
    ("San Pedro Ayampuc", 7),("San Pedro Sacatepéquez", 7),("San Juan Sacatepéquez", 7),("San Raymundo", 7),
    ("Chuarrancho", 7),("Fraijanes", 7),("Amatitlán", 7),("Villa Canales", 7),
    ("San Miguel Petapa", 7),
    
    
    ("Aguacatán", 8),("Chiantla", 8),("Colotenango", 8),("Concepción Huista", 8),
    ("Cuilco", 8),("Huehuetenango", 8),("Jacatenango", 8),("La Democracia", 8),
    ("La Libertad", 8),("Malacatancito", 8),("Nentón", 8),("Petatán", 8),
    ("San Antonio Huista", 8),("San Gaspar Ixchil", 8),("Ixtahuacán", 8),("San Juan Atitán", 8),
    ("San Juan Ixcoy", 8),("San Mateo Ixtatán", 8),("San Miguel Acatán", 8),
    
    
    ("Puerto Barrios", 9),("Livingston", 9),("El Estor", 9),("Morales", 9),
    ("Los Amates", 9),
    
    
    ("Jalapa", 10),("Mataquescuintla", 10),("Monjas", 10),("San Carlos Alzatate", 10),
    ("San Luis Jilotepeque", 10),("San Pedro Pinula", 10),("San Manuel Chaparrón", 10),
    
    
    
    ("Agua Blanca", 11),("Asunción Mita", 11),("Atescatempa", 11),("Comapa", 11),
    ("Conguaco", 11),("El Adelanto", 11),("El Progreso", 11),("Jalpatagua", 11),
    ("Jerez", 11),("Jutiapa", 11),("Moyuta", 11),("Pasaco", 11),
    ("Quesada", 11),("San José Acatempa", 11),("Santa Catarina Mita", 11),("Yupilotepeque", 11),
    ("Zapotitlán", 11),
    
    
    ("Dolores", 12),("Flores", 12),("La Libertad", 12),("Melchor de Mencos", 12),
    ("Poptún", 12),("San Andrés", 12),("San Benito", 12),("San Francisco", 12),
    ("San José", 12),("San Luis", 12),("Santa Ana", 12),("Sayaxché", 12),
    ("Las Cruces", 12),("El Chal", 12),
    
    
    
    ("Almolonga",13),("Cabricán",13),("Cajolá",13),("Cantel",13),
    ("Coatepeque",13),("Colomba",13),("Concepción Chiquirichapa",13),("El Palmar",13),
    ("Flores Costa Cuca",13),("Génova",13),("Huitán",13),("La Esperanza",13),
    ("Olintepeque",13),("Palestina de Los Altos",13),("Quetzaltenango",13),("Salcajá",13),
    ("San Carlos Sija",13),("San Juan Ostuncalco",13),("San Francisco La Union",13),("San Martín Sacatepéquez",13),
    ("San Mateo",13),("San Miguel Sigüilá",13),("Sibilia",13),("Zunil",13),
    
     
	("Canillá", 14),("Santa Cruz del Quiché", 14),("Chajul", 14),("Chicamán", 14),
    ("Chiché", 14),("Chichicastenango", 14),("Chinique", 14),("Cunén", 14),
    ("Ixcán", 14),("Joyabaj", 14),("Pachalum", 14),("Patzité", 14),
    ("Sacapulas", 14),("San Andrés Sajcabajá", 14),("San Antonio Ilotenango", 14),("San Bartolomé Jocotenango", 14),
    ("San Juan Cotzal", 14),("San Pedro Jocopilas", 14),("Santa María Nebaj", 14),("Uspantán", 14),
    ("Zacualpa", 14),
    
    
    ("Champerico", 15),("El Asintal", 15),("Nuevo San Carlos", 15),("Retalhuleu", 15),
    ("San Andrés Villa Seca", 15),("San Felipe", 15),("San Martín Zapolitán", 15),("San Sebastián", 15),
    ("Santa Cruz Muluá", 15),
    
    
    ("Alotenango", 16), ("Antigua Guatemala", 16),("Ciudad Vieja", 16),("Jocotenango", 16),
    ("Magdalena Milpas Altas", 16),("Pastores", 16),("San Antonio Aguas Calientes", 16),("San Bartolomé Milpas Altas", 16),
    ("San Lucas Sacatepéquez", 16),("San Miguel Dueñas", 16),("Santa Catarina Barahona", 16),("Santa Lucía Milpas Altas", 16),
    ("Santa María de Jesús", 16),("Santiago Sacatepéquez", 16),("Santo Domingo Xenacoj", 16),("Sumpango", 16),
        
       
	("Ayutla",17),("San Marcos",17),("Catarina",17),("Comitancillo",17),
    ("Concepción Tutuapa",17),("El Quetzal",17),("El Rodeo",17),("El Tumbador",17),
    ("Ixchiguán",17),("La Reforma",17),("Malacatán",17),("Nuevo Progreso",17),
    ("Ocós",17),("Pajapita",17),("Esquipulas Palo Gordo",17),("San Antonio Sacatepéquez",17),
    ("San Cristóbal Cucho",17),("San José Ojetenam",17),("San Lorenzo",17),("San Miguel Ixtahuacán",17),
    ("San Pablo",17),("San Pedro Sacatepéquez",17),("San Rafael Pie de la Cuesta",17),("Sibinal",17),
    ("Sipacapa",17),("Tacaná",17),("Tajumulco",17),("Tejutla",17),("Río Blanco",17),
    ("La Blanca",17),
	
    
    
    ("Barberena",18),("Casillas",18),("Chiquimulilla",18),("Cuilapa",18),
    ("Guazacapán",18),("Monterrico",18),("Nueva Santa Rosa",18),("Oratorio",18),
    ("Pueblo Nuevo Viñas",18),("San Juan Tecuaco",18),("San Rafael Las Flores",18),("Santa Cruz Naranjo",18),
    ("Santa María Ixhuatán",18),("Santa Rosa de Lima",18),("Taxisco",18),
        
	("Sololá", 19),("Concepción", 19),("Nahualá", 19),("Panajachel", 19),
    ("San Andrés Semetabaj", 19),("San Antonio Palopó", 19),("San José Chacayá", 19),("San Juan La Laguna", 19),
    ("San Lucas Tolimán", 19),("San Marcos La Laguna", 19),("San Pablo La Laguna", 19),("San Pedro La Laguna", 19),
    ("Santa Catarina Ixtahuacán", 19),("Santa Catarina Palopó", 19),("Santa Clara La Laguna", 19),("Santa Cruz La Laguna", 19),
    ("Santa Lucía Utatlán", 19),("Santa María Visitación", 19),("Santiago Atitlán", 19),
        
        
    ("Chicacao",20),("Cuyotenango",20),("Mazatenango",20),("Patulul",20),
    ("Pueblo Nuevo",20),("Río Bravo",20),("Samayac",20),("San Antonio Suchitepéquez",20),
    ("San Bernardino",20),("San Francisco Zapolitán",20),("San Gabriel",20),("San José El Ídolo",20),
    ("San José La Máquina",20),("San Juan Bautista",20),("San Lorenzo",20),("San Miguel Panán",20),
    ("San Pablo Jocopilas",20),("Santa Bárbara",20),("Santo Domingo Suchitepéquez",20),("Santo Tomás La Unión",20),
    ("Zunilito",20),
    
    
    ("Momostenango", 21),("San Andrés Xecul", 21),("San Bartolo", 21),("San Cristóbal Totonicapán", 21),
    ("San Francisco El Alto", 21),("Santa María Chiquimula", 21),("Santa Lucía la Reforma", 21),("Totonicapán", 21),
    
    
    ("Cabañas",22),("Estanzuela",22),("Gualán",22),("Huité",22),
    ("La Unión",22),("Río Hondo",22),("San Diego",22),("San Jorge",22),
    ("Teculután",22),("Usumatlán",22),("Zacapa",22)
    ;
	
END//
DELIMITER ;




#llamadas genéricas
call proc_roles();
call proc_default_values();

# referencia de las categorias: https://www.merca20.com/6-categorias-en-las-que-puedes-clasificar-tu-producto/
INSERT INTO categoria (nombre)
	VALUES ("Nuevos"),
			("Estrella"),
            ("Seguidores"),
            ("Apoyo"),
            ("Temporada"),
            ("A la baja");
            
commit;

