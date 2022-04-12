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
@Table(name = "PERITO")
@Data
@SequenceGenerator(name = "sqcPerito", sequenceName = "SQC_PERITO", allocationSize = 1)
public class Perito implements Serializable {

	private static final long serialVersionUID = -342527753449838324L;

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "sqcPerito")
	@Column(name = "DNI_PERITO")
	private Integer dniPerito;

	@Column(name = "NOMBRE_PERITO")
	private String nombrePerito;

	@Column(name = "APELLIDO_PERITO1")
	private String apellidoPerito1;

	@Column(name = "APELLIDO_PERITO2")
	private String apellidoPerito2;

	@Column(name = "TELEFONO_CONTACTO")
	private Integer telefonoContacto;

	@Column(name = "TELEFONO_OFICINA")
	private Integer telefonoOficina;

	@Column(name = "CLASE_VIA")
	private String claseVia;

	@Column(name = "NOMBRE_VIA")
	private String nombreVia;

	@Column(name = "NUMERO_VIA")
	private String numeroVia;

	@Column(name = "COD_POSTAL")
	private String codPostal;

	@Column(name = "CIUDAD")
	private String ciudad;

}
