package univers.curso.practicados.dto;

import java.io.Serializable;

import lombok.Data;

@Data
public class GroupByDto implements Serializable {

	private static final long serialVersionUID = 1L;

	String apellido;

	Long cantidad;

	String ciudad;

	public GroupByDto(String apellido, Long cantidad, String ciudad) {
		super();
		this.apellido = apellido;
		this.cantidad = cantidad;
		this.ciudad = ciudad;
	}

}
