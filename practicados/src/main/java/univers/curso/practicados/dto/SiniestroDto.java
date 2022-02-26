package univers.curso.practicados.dto;

import java.io.Serializable;
import java.util.Date;

import lombok.Data;
import univers.curso.practicados.entity.Perito;

@Data
public class SiniestroDto implements Serializable {

	private static final long serialVersionUID = 8181319699082016266L;

	private Integer idSiniestro;
	private Date fechaSiniestro;
	private String causas;
	private String aceptado;
	private String indemnizacion;
	private Integer numeroPoliza;
	private Perito perito;

}
