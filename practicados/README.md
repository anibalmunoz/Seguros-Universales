# Descripción General del proyecto: 
**Servicios restful, base de datos de seguros en Oracle.**

# Versión del proyecto:
**1.0.0**

# Requisitos para integración y ejecución:
* Se necesita tener JDK 8.
* Se recomienda Spring Tool Suite (solamente si necesitas editar el proyecto).
* Se debe tener maven instalado (versión 3.8.4 recomendada).
* Motor de base de datos Oracle (Se recomienda versión 11g XE).
* Docker (version 19.03.5 recomendada).

# Guia para instalación y funcionamiento

1. Lo primero que debes hacer es crear tu base de datos para lo cual necesitas tener un usuario **practicados** identificado con la contraseña **practicados**.
2. Luego de tener tu usuario y tu conexión al esquema, debes ejecutar el documento **practicados(limpio).sql** el cual te creará las tablas, secuencias, paquetes, funciones y procedimientos en tu base de datos.

#### Si has modificado el proyecto debes hacer los siguientes pasos, si no lo modificas no es necesario realizar estos pasos:

3. Ubicarte en la carpeta del proyecto y ejecutar el siguiente comando para construir el proyecto. Esto modificará la carpeta target y construirá el proyecto con las modificaciones realizadas.

`$ mvn clean install package`

#### Si no has modificado el proyecto puedes omitir el paso 3

4. En este proyecto ya está el archivo **Dockerfile** el cual es necesario para construir la imagen de Docker, por lo que debes ubicarte en esta carpeta desde una consola y ejecutar el siguiente comando para crear la imagen de docker.

`$ docker build -t nombredeimagen .`

5. Si tienes tu base de datos creada, y tienes docker correctamente instalado, puedes ejecutar tu imagen con el siguiente comando.

`$ docker run -p 9595:9595 nombredeimagen`

6. Puedes realizar tus pruebas ejecutanto los servicios get, post y delete con los cuales se compone el proyecto por ejemplo el siguiente.

`localhost:9595/cliente/buscar`

7. Para tener todos los enlaces disponibles en el proyecto puedes acceder al archivo **PracticaDos.postman_collection.json** en el cual se encuentran todos los url de los servicios de los que se compone el proyecto.

8. Una vez tengas tu imagen de docker corriendo, puedes utilizar el siguiente comando para ver el log en tu consola.

`docker logs --tail 1000 -f flamboyant_taussig`
