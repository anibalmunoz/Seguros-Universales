package univers.curso.practicados.entity;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;


@Entity
@Table(name = "USUARIO")

@SequenceGenerator(name = "sqcUsuario", sequenceName = "SQC_USUARIO", allocationSize = 1)
public class Usuario implements Serializable{

	
	/**
	 * 
	 */
	private static final long serialVersionUID = -5686892217579656377L;
	
	

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "sqcUsuario")
	@Column(name = "IDUSUARIO")
	private Integer iduduario;

	@Column(name = "CORREO")
	private String correo;

	@Column(name = "CONTRASENA")
	private String contrasena;
	
	@Column(name = "NOMBRE")
	private String nombre;
	
	
	

	public Integer getIduduario() {
		return iduduario;
	}

	public void setIduduario(Integer iduduario) {
		this.iduduario = iduduario;
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
