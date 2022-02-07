package univers.curso.practicados.dto;

import java.io.Serializable;

import lombok.Data;
@Data
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

}
