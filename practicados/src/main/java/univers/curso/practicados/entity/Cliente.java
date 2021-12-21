package univers.curso.practicados.entity;

import java.io.Serializable;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

@Entity
@Table(name = "CLIENTE")
public class Cliente implements Serializable {

	private static final long serialVersionUID = -2401368180924723332L;

	@Id
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

	@OneToMany(mappedBy = "dniCl", cascade=CascadeType.ALL, orphanRemoval = true)
	private List<Seguro> segurosList;

	public List<Seguro> getSegurosList() {
		return segurosList;
	}
	
	

	public void setSegurosList(List<Seguro> segurosList) {
		this.segurosList = segurosList;
	}

	public Integer getDniCl() {
		return dniCl;
	}

	public void setDniCl(Integer dniCl) {
		this.dniCl = dniCl;
	}

	public String getNombreCl() {
		return nombreCl;
	}

	public void setNombreCl(String nombreCl) {
		this.nombreCl = nombreCl;
	}

	public String getApellido1() {
		return apellido1;
	}

	public void setApellido1(String apellido1) {
		this.apellido1 = apellido1;
	}

	public String getApellido2() {
		return apellido2;
	}

	public void setApellido2(String apellido2) {
		this.apellido2 = apellido2;
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

	public String getCiudad() {
		return ciudad;
	}

	public void setCiudad(String ciudad) {
		this.ciudad = ciudad;
	}

	public Integer getTelefono() {
		return telefono;
	}

	public void setTelefono(Integer telefono) {
		this.telefono = telefono;
	}

	public String getObservaciones() {
		return observaciones;
	}

	public void setObservaciones(String observaciones) {
		this.observaciones = observaciones;
	}

}
