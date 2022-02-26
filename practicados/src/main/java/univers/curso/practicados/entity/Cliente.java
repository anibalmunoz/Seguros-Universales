package univers.curso.practicados.entity;

import java.io.Serializable;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

import lombok.Data;

@Entity
@Table(name = "CLIENTE")

@SequenceGenerator(name = "sqcCliente", sequenceName = "SQC_CLIENTE", allocationSize = 1)
@Data
@NamedQuery(name = "Cliente.buscarTodos", query = "SELECT c FROM Cliente c")

public class Cliente implements Serializable {

	private static final long serialVersionUID = -2401368180924723332L;

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "sqcCliente")
	@Column(name = "DNI_CL")
	private Integer dniCl;

	@Column(name = "NOMBRE_CL")
	private String nombreCl;

	@Column(name = "APELLIDO_1")
	private String apellido1;

	@Column(name = "APELLIDO_2")
	private String apellido2;

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

	@Column(name = "TELEFONO")
	private Integer telefono;

	@Column(name = "OBSERVACIONES")
	private String observaciones;

	@OneToMany(mappedBy = "dniCl", cascade = CascadeType.ALL, orphanRemoval = false)
	private List<Seguro> segurosList;

}
