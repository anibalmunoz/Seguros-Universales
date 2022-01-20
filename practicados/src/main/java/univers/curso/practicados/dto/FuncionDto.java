package univers.curso.practicados.dto;

import java.io.Serializable;

public class FuncionDto implements Serializable {

	private static final long serialVersionUID = 1L;

	public Integer getpNumeroPoliza() {
		return pNumeroPoliza;
	}

	public void setpNumeroPoliza(Integer pNumeroPoliza) {
		this.pNumeroPoliza = pNumeroPoliza;
	}

	private Integer pNumeroPoliza;

}
