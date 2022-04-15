package univers.curso.practicados.entity;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

import lombok.Data;

@Entity
@Table(name = "USUARIO")

@SequenceGenerator(name = "sqcUsuario", sequenceName = "SQC_USUARIO", allocationSize = 1)
@Data
public class Usuario implements Serializable{

	
	private static final long serialVersionUID = 8721804543795104871L;


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
	

}
