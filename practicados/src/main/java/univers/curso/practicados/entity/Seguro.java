package univers.curso.practicados.entity;

import java.io.Serializable;
import java.util.Date;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import com.fasterxml.jackson.annotation.JsonIgnore;

import lombok.Data;

@Entity
@Table(name = "SEGURO")

@SequenceGenerator(name = "sqcSeguro", sequenceName = "SQC_SEGURO", allocationSize = 1)
@Data
public class Seguro implements Serializable {

	private static final long serialVersionUID = 5008886135637348016L;

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "sqcSeguro")
	@Column(name = "NUMERO_POLIZA")
	private Integer numeroPoliza;

	@Column(name = "RAMO")
	private String ramo;

	@Temporal(TemporalType.DATE)
	@Column(name = "FECHA_INICIO")
	private Date fechaInicio;

	@Temporal(TemporalType.DATE)
	@Column(name = "FECHA_VENCIMIENTO")
	private Date fechaVencimiento;

	@Column(name = "CONDICIONES_PARTICULARES")
	private String condicionesParticulares;

	@Column(name = "OBSERVACIONES")
	private String obervaciones;

	@Column(name = "DNI_CL")
	private Integer dniCl;

	@ManyToMany(cascade = { CascadeType.PERSIST, CascadeType.MERGE })
	@JoinTable(name = "COMPANIA_SEGURO", joinColumns = { @JoinColumn(name = "NUMERO_POLIZA") }, inverseJoinColumns = {
			@JoinColumn(name = "NOMBRE_COMPANIA") })
	@JsonIgnore
	private Set<Compania> companias;

}
