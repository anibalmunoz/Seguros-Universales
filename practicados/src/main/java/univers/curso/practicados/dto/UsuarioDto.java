package univers.curso.practicados.dto;

import java.io.Serializable;

import lombok.Data;

@Data
public class UsuarioDto implements Serializable{

	private static final long serialVersionUID = -2695188259407095229L;

	
	private Integer idusuario;
	private String correo;
	private String contrasena;	
	private String nombre;

}
