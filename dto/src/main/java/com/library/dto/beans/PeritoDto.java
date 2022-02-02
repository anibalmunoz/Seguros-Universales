package com.library.dto.beans;

import java.io.Serializable;

import lombok.Data;

@Data
public class PeritoDto implements Serializable {

	private static final long serialVersionUID = 7625323826079335826L;

	private Integer dniPerito;
	private String nombrePerito;
	private String apellidoPerito1;
	private String apellidoPerito2;
	private Integer telefonoContacto;
	private Integer telefonoOficina;
	private String claseVia;
	private String nombreVia;
	private String numeroVia;
	private String codPostal;
	private String ciudad;


}
