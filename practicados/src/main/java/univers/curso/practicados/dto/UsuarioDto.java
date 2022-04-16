package univers.curso.practicados.dto;

import java.io.Serializable;


public class UsuarioDto implements Serializable{


	
	/**
	 * 
	 */
	private static final long serialVersionUID = 3073531405939161839L;
	
	
	private Integer idusuario;
	private String correo;
	private String contrasena;	
	private String nombre;
	
	
	
	public Integer getIdusuario() {
		return idusuario;
	}
	public void setIdusuario(Integer idusuario) {
		this.idusuario = idusuario;
	}
	public String getCorreo() {
		return correo;
	}
	public void setCorreo(String correo) {
		this.correo = correo;
	}
	public String getContrasena() {
		return contrasena;
	}
	public void setContrasena(String contrasena) {
		this.contrasena = contrasena;
	}
	public String getNombre() {
		return nombre;
	}
	public void setNombre(String nombre) {
		this.nombre = nombre;
	}

	
	
}
