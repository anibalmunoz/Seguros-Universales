package univers.curso.practicados.entity;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "PERITO")
public class Perito implements Serializable {

	private static final long serialVersionUID = -342527753449838324L;

	@Id
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
	
	@Column(name="NUMERO_VIA")
	private String numeroVia;
	
	@Column(name="COD_POSTAL")
	private String codPostal;
	
	@Column(name="CIUDAD")
	private String ciudad;

	public Integer getDniPerito() {
		return dniPerito;
	}

	public void setDniPerito(Integer dniPerito) {
		this.dniPerito = dniPerito;
	}

	public String getNombrePerito() {
		return nombrePerito;
	}

	public void setNombrePerito(String nombrePerito) {
		this.nombrePerito = nombrePerito;
	}

	public String getApellidoPerito1() {
		return apellidoPerito1;
	}

	public void setApellidoPerito1(String apellidoPerito1) {
		this.apellidoPerito1 = apellidoPerito1;
	}

	public String getApellidoPerito2() {
		return apellidoPerito2;
	}

	public void setApellidoPerito2(String apellidoPerito2) {
		this.apellidoPerito2 = apellidoPerito2;
	}

	public Integer getTelefonoContacto() {
		return telefonoContacto;
	}

	public void setTelefonoContacto(Integer telefonoContacto) {
		this.telefonoContacto = telefonoContacto;
	}

	public Integer getTelefonoOficina() {
		return telefonoOficina;
	}

	public void setTelefonoOficina(Integer telefonoOficina) {
		this.telefonoOficina = telefonoOficina;
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
	
	

}
