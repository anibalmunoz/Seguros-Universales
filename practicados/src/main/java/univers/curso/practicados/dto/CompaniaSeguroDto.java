package univers.curso.practicados.dto;

import java.io.Serializable;



import lombok.Data;

@Data
public class CompaniaSeguroDto implements Serializable {
	/**
	* 
	*/
	private static final long serialVersionUID = -5497101554008445451L;

	private Integer id;

	private Integer numeroPoliza;

	private String nombreCompania;

}
