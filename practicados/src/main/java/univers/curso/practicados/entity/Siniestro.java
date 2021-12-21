package univers.curso.practicados.entity;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

@Entity
public class Siniestro implements Serializable {

	private static final long serialVersionUID = 1016402528707777371L;

	@Id
	@Column(name = "ID_SINIESTRO")
	private Integer idSiniestro;

	@Temporal(TemporalType.DATE)
	@Column(name = "FECHA_SINIESTRO")
	private Date fechaSiniestro;

	@Column(name = "CAUSAS")
	private String causas;

	@Column(name = "ACEPTADO")
	private String aceptado;

	@Column(name = "INDEMNIZACION")
	private String indemnizacion;

	@Column(name = "NUMERO_POLIZA")
	private Integer numeroPoliza;

	@ManyToOne()
	@JoinColumn(name = "DNI_PERITO")
	private Perito perito;
	
	public Integer getNumeroPoliza() {
		return numeroPoliza;
	}

	public void setNumeroPoliza(Integer numeroPoliza) {
		this.numeroPoliza = numeroPoliza;
	}

	public Perito getPerito() {
		return perito;
	}

	public void setPerito(Perito perito) {
		this.perito = perito;
	}

	public Integer getIdSiniestro() {
		return idSiniestro;
	}

	public void setIdSiniestro(Integer idSiniestro) {
		this.idSiniestro = idSiniestro;
	}

	public Date getFechaSiniestro() {
		return fechaSiniestro;
	}

	public void setFechaSiniestro(Date fechaSiniestro) {
		this.fechaSiniestro = fechaSiniestro;
	}

	public String getCausas() {
		return causas;
	}

	public void setCausas(String causas) {
		this.causas = causas;
	}

	public String getAceptado() {
		return aceptado;
	}

	public void setAceptado(String aceptado) {
		this.aceptado = aceptado;
	}

	public String getIndemnizacion() {
		return indemnizacion;
	}

	public void setIndemnizacion(String indemnizacion) {
		this.indemnizacion = indemnizacion;
	}


}
