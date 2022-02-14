/*
*   El usuario de base de datos se llama "practicados"  y la contraseña es "practicados"  (usuario y contraseña sin comillas).
*   
*/



/*CREAR TABLA DE CLIENTE*/
CREATE TABLE cliente (
    dni_cl NUMBER(10),
    nombre_cl VARCHAR(30),
    apellido_1 VARCHAR(30),
    apellido_2 VARCHAR(30),
    clase_via VARCHAR(30),
    nombre_via VARCHAR(30),
    numero_via VARCHAR(30),
    cod_postal VARCHAR(50),
    ciudad VARCHAR(50),
    telefono NUMBER(15),
    observaciones VARCHAR(200),
    CONSTRAINT pk_cliente PRIMARY KEY (dni_cl)
);

/*CREAR TABLA DE SEGURO*/
CREATE TABLE seguro (
    numero_poliza NUMBER(10),
    ramo VARCHAR(30),
    fecha_inicio DATE,
    fecha_vencimiento DATE,
    condiciones_particulares VARCHAR(100),
    observaciones VARCHAR(50),
    dni_cl NUMBER(10),
    CONSTRAINT pk_seguro PRIMARY KEY (numero_poliza),
    CONSTRAINT fk_segurocliente FOREIGN KEY (dni_cl) REFERENCES cliente (dni_cl)
);

/*TABLA COMPANIA*/
CREATE TABLE compania (
    nombre_compania VARCHAR(25),
    clase_via VARCHAR(30),
    nombre_via VARCHAR(30),
    numero_via VARCHAR(30),
    cod_postal VARCHAR(30),
    telefono_contratacion VARCHAR(30),
    telefono_siniestros VARCHAR(30),
    notas VARCHAR(50),
    CONSTRAINT pk_compania PRIMARY KEY (nombre_compania)
);


/*CREAR TABLA DE COMPANIAS_SEGUROS*/
CREATE TABLE compania_seguro (
    id NUMBER(10),
    numero_poliza NUMBER(10),
    nombre_compania VARCHAR(25),
    CONSTRAINT pk_comp_seguro PRIMARY KEY (id),
    CONSTRAINT fk_numeropoliza_compseg FOREIGN KEY (numero_poliza) REFERENCES seguro (numero_poliza),
    CONSTRAINT fk_nombrecompania_compseg FOREIGN KEY (nombre_compania) REFERENCES compania (nombre_compania)
);



/*TABLA PERITO*/
CREATE TABLE perito (
    dni_perito NUMBER(10),
    nombre_perito VARCHAR(25),
    apellido_perito1 VARCHAR(25),
    apellido_perito2 VARCHAR(25),
    telefono_contacto NUMBER(15),
    telefono_oficina NUMBER(15),
    clase_via VARCHAR(30),
    nombre_via VARCHAR(30),
    numero_via VARCHAR(30),
    cod_postal VARCHAR(30),
    ciudad VARCHAR(30),
    CONSTRAINT pk_perito PRIMARY KEY (dni_perito)
);

/*SINIESTRO*/
CREATE TABLE siniestro (
    id_siniestro NUMBER(10),
    fecha_siniestro DATE,
    causas VARCHAR(100),
    aceptado VARCHAR(100),
    indemnizacion VARCHAR(30),
    numero_poliza NUMBER(10),
    dni_perito NUMBER(25),
    CONSTRAINT pk_siniestro PRIMARY KEY (id_siniestro),
    CONSTRAINT fk_seguro FOREIGN KEY (numero_poliza) REFERENCES seguro (numero_poliza),
    CONSTRAINT fk_perito FOREIGN KEY (dni_perito) REFERENCES perito (dni_perito)
);



/*Funcion para obtener nombre de un cliente*/
create or replace FUNCTION OBTENER_NOMBRE(
    P_DNI_CL IN CLIENTE.DNI_CL % TYPE   
    )
RETURN VARCHAR2
AS
     NOMBRE VARCHAR2(50);
BEGIN

   SELECT NOMBRE_CL INTO NOMBRE FROM CLIENTE WHERE DNI_CL = P_DNI_CL;
    RETURN NOMBRE;

END;

/*creacion de secuencia cliente*/
     
CREATE SEQUENCE SQC_CLIENTE
START WITH 1
MINVALUE 1 
NOMAXVALUE
INCREMENT BY 1
CACHE 20;

/*CREACION DE SECUENCIA PARA SEGURO*/

CREATE SEQUENCE SQC_SEGURO
START WITH 1
MINVALUE 1 
NOMAXVALUE
INCREMENT BY 1
CACHE 20;



/*PROCEDIMIENTO PARA INSERTAR UNA POLIZA Y OBTENER EL NUMERO DE POLIZA Y NUMERO DE CLIENTE COMO RETORNO*/
create or replace PROCEDURE INSERT_SEGURO_RETURN(
    P_NUMERO_POLIZA IN OUT SEGURO.NUMERO_POLIZA % TYPE,
    P_RAMO IN SEGURO.RAMO % TYPE,
    P_FECHA_INICIO IN SEGURO.FECHA_INICIO % TYPE,
    P_FECHA_VENCIMIENTO IN SEGURO.FECHA_VENCIMIENTO % TYPE,
    P_CONDICIONES_PARTICULARES IN SEGURO.CONDICIONES_PARTICULARES % TYPE,
    P_OBSERVACIONES IN SEGURO.OBSERVACIONES % TYPE,
    P_DNI_CL IN OUT SEGURO.DNI_CL % TYPE,
    P_NOMBRE_CL OUT CLIENTE.NOMBRE_CL % TYPE
) IS 

BEGIN
    INSERT INTO  SEGURO VALUES(
        SQC_SEGURO.nextval,
        p_ramo,
        p_fecha_inicio,
        p_fecha_vencimiento,
        p_condiciones_particulares,
        P_OBSERVACIONES,
        P_DNI_CL
    );   

    P_NUMERO_POLIZA := SQC_SEGURO.CURRVAL;

    select NOMBRE_CL into P_NOMBRE_CL from CLIENTE where DNI_CL = P_DNI_CL;

EXCEPTION
WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE('HUBO UN ERROR');
END;

/*
CREACION DEL PAQUETE EN EL CUAL SE GUARDARA LA FUNCION PARA AGREGAR NUEVA POLIZA
*/
create or replace PACKAGE PAQUETE
IS
FUNCTION INSERTAR_SEGURO(
    P_RAMO IN SEGURO.RAMO % TYPE,
    P_FECHA_INICIO IN SEGURO.FECHA_INICIO % TYPE,
    P_FECHA_VENCIMIENTO IN SEGURO.FECHA_VENCIMIENTO % TYPE,
    P_CONDICIONES_PARTICULARES IN SEGURO.CONDICIONES_PARTICULARES % TYPE,
    P_OBSERVACIONES IN SEGURO.OBSERVACIONES % TYPE,
    P_DNI_CL IN SEGURO.DNI_CL % TYPE)
    RETURN INTEGER;
END;

                                    /*CREACION DEL PACKAGE BODY EN DONDE VA LA LOGICA DE LA FUNCION*/
                                    
                    create or replace PACKAGE BODY PAQUETE
                    IS
                    FUNCTION INSERTAR_SEGURO(
                        P_RAMO  SEGURO.RAMO % TYPE,
                        P_FECHA_INICIO  SEGURO.FECHA_INICIO % TYPE,
                        P_FECHA_VENCIMIENTO  SEGURO.FECHA_VENCIMIENTO % TYPE,
                        P_CONDICIONES_PARTICULARES  SEGURO.CONDICIONES_PARTICULARES % TYPE,
                        P_OBSERVACIONES  SEGURO.OBSERVACIONES % TYPE,
                        P_DNI_CL  SEGURO.DNI_CL % TYPE
                    )RETURN INTEGER
                    AS
                                POLIZA INTEGER;

                                BEGIN
                                INSERT INTO  SEGURO VALUES(
                                    SQC_SEGURO.NEXTVAL,
                                    p_ramo,
                                    p_fecha_inicio,
                                    p_fecha_vencimiento,
                                    p_condiciones_particulares,
                                    P_OBSERVACIONES,
                                    P_DNI_CL
                                );
                                DBMS_OUTPUT.PUT_LINE('SEGURO INSERTADO CORRECTAMENTE');
                                POLIZA := SQC_SEGURO.CURRVAL;

                                RETURN POLIZA;
                                END INSERTAR_SEGURO;


                    END PAQUETE;

















