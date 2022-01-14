package univers.curso.practicados.dto;

import java.io.Serializable;

public class ProcedimientoDto implements Serializable {

	private static final long serialVersionUID = 1L;

	private Integer pNumeroPoliza;
	private Integer pDniCl;
	private String pNombreCl;
	
	public String getpNombreCl() {
		return pNombreCl;
	}
	public void setpNombreCl(String pNombreCl) {
		this.pNombreCl = pNombreCl;
	}
	public Integer getpNumeroPoliza() {
		return pNumeroPoliza;
	}
	public void setpNumeroPoliza(Integer pNumeroPoliza) {
		this.pNumeroPoliza = pNumeroPoliza;
	}	
	public Integer getpDniCl() {
		return pDniCl;
	}
	public void setpDniCl(Integer pDniCl) {
		this.pDniCl = pDniCl;
	}
	
}
