package universales.apiGetTres.apiGetTres;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

@JsonIgnoreProperties(ignoreUnknown = true)
public class Value {
	private Long id;

	  public Value() {
	  }

	  public Long getId() {
	    return this.id;
	  }

	

	  public void setId(Long id) {
	    this.id = id;
	  }

	 

	  @Override
	  public String toString() {
	    return "Value{" +
	        "id=" + id +
	        '}';
	  }
}
