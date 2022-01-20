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

@Entity
@Table(name = "SEGURO")

@SequenceGenerator(
	    name="sqcSeguro",
	    sequenceName =  "SQC_SEGURO",
	    allocationSize = 1
	)
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
	
	@ManyToMany(cascade= {
			CascadeType.PERSIST,
			CascadeType.MERGE
	})
	@JoinTable(
			name = "COMPANIA_SEGURO",
			joinColumns = {@JoinColumn(name="NUMERO_POLIZA")},
			inverseJoinColumns = {@JoinColumn(name="NOMBRE_COMPANIA")}
			)
	@JsonIgnore
	private Set<Compania> companias;

	public Set<Compania> getCompanias() {
		return companias;
	}

	public void setCompanias(Set<Compania> companias) {
		this.companias = companias;
	}

	public Integer getNumeroPoliza() {
		return numeroPoliza;
	}

	public void setNumeroPoliza(Integer numeroPoliza) {
		this.numeroPoliza = numeroPoliza;
	}

	public String getRamo() {
		return ramo;
	}

	public void setRamo(String ramo) {
		this.ramo = ramo;
	}

	public Date getFechaInicio() {
		return fechaInicio;
	}

	public void setFechaInicio(Date fechaInicio) {
		this.fechaInicio = fechaInicio;
	}

	public Date getFechaVencimiento() {
		return fechaVencimiento;
	}

	public void setFechaVencimiento(Date fechaVencimiento) {
		this.fechaVencimiento = fechaVencimiento;
	}

	public String getCondicionesParticulares() {
		return condicionesParticulares;
	}

	public void setCondicionesParticulares(String condicionesParticulares) {
		this.condicionesParticulares = condicionesParticulares;
	}

	public String getObervaciones() {
		return obervaciones;
	}

	public void setObervaciones(String obervaciones) {
		this.obervaciones = obervaciones;
	}

	public Integer getDniCl() {
		return dniCl;
	}

	public void setDniCl(Integer dniCl) {
		this.dniCl = dniCl;
	}

	
	
}
