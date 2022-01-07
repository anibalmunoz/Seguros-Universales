package univers.curso.practicados.dto;

import java.io.Serializable;
import java.util.Set;

import univers.curso.practicados.entity.Seguro;

public class CompaniaDto implements Serializable {

	private static final long serialVersionUID = 7764378410142344502L;
	
	private String nombreCompania;
	private String claseVia;
	private String nombreVia;
	private String numeroVia;
	private String codPostal;
	private String telefonoContratacion;
	private String telefonoSiniestros;
	private String notas;
	private Set<Seguro> seguros;
	
	
	public String getNombreCompania() {
		return nombreCompania;
	}
	public void setNombreCompania(String nombreCompania) {
		this.nombreCompania = nombreCompania;
	}
	public String getClaseVia() {
		return claseVia;
	}
	public void setClaseVia(String claseVia) {
		this.claseVia = claseVia;
	}
	public String getNombreVia() {
		return nombreVia;
	}
	public void setNombreVia(String nombreVia) {
		this.nombreVia = nombreVia;
	}
	public String getNumeroVia() {
		return numeroVia;
	}
	public void setNumeroVia(String numeroVia) {
		this.numeroVia = numeroVia;
	}
	public String getCodPostal() {
		return codPostal;
	}
	public void setCodPostal(String codPostal) {
		this.codPostal = codPostal;
	}
	public String getTelefonoContratacion() {
		return telefonoContratacion;
	}
	public void setTelefonoContratacion(String telefonoContratacion) {
		this.telefonoContratacion = telefonoContratacion;
	}
	public String getTelefonoSiniestros() {
		return telefonoSiniestros;
	}
	public void setTelefonoSiniestros(String telefonoSiniestros) {
		this.telefonoSiniestros = telefonoSiniestros;
	}
	public String getNotas() {
		return notas;
	}
	public void setNotas(String notas) {
		this.notas = notas;
	}
	public Set<Seguro> getSeguros() {
		return seguros;
	}
	public void setSeguros(Set<Seguro> seguros) {
		this.seguros = seguros;
	}

	
	
}
