package univers.curso.practicados.dto;

import java.io.Serializable;
import java.util.List;

import lombok.Data;

@Data
public class GroupByDto implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	List<String> nombrePerito;

}
