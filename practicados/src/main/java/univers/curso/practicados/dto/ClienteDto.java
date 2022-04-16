package univers.curso.practicados.dto;

import java.io.Serializable;


import lombok.Data;

@Data
public class ClienteDto implements Serializable {

	private static final long serialVersionUID = 7179031096384936620L;

	private Integer dniCl;
	private String nombreCl;
	private String apellido1;
	private String apellido2;
	private String claseVia;
	private String nombreVia;
	private String numeroVia;
	private String codPostal;
	private String ciudad;
	private Integer telefono;
	private String observaciones;
	
	private String correo;
	private String contrasena;

}
