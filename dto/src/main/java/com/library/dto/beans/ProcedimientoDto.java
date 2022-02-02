package com.library.dto.beans;

import java.io.Serializable;

import lombok.Data;
@Data
public class ProcedimientoDto implements Serializable {

	private static final long serialVersionUID = 1L;

	private Integer pNumeroPoliza;
	private Integer pDniCl;
	private String pNombreCl;

}
