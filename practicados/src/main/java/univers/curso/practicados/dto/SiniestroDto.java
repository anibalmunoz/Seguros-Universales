package univers.curso.practicados.dto;

import java.io.Serializable;
import java.util.Date;

import univers.curso.practicados.entity.Perito;

public class SiniestroDto implements Serializable{

	private static final long serialVersionUID = 8181319699082016266L;
	
	private Integer idSiniestro;
	private Date fechaSiniestro;
	private String causas;
	private String aceptado;
	private String indemnizacion;
	private Integer numeroPoliza;
	private Perito perito;
	
	
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

	
	
}
