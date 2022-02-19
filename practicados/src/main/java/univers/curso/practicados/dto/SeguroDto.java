package univers.curso.practicados.dto;

import java.io.Serializable;
import java.util.Date;
import lombok.Data;

@Data
public class SeguroDto implements Serializable {

	private static final long serialVersionUID = -4333012104927311458L;

	private Integer numeroPoliza;
	private String ramo;
	private Date fechaInicio;
	//@JsonFormat(shape=JsonFormat,Shape.STRING,pattern="dd/MM/yyyy",timezone "GMT-6")
	private Date fechaVencimiento;
	private String condicionesParticulares;
	private String obervaciones;
	private Integer dniCl;

	
}
