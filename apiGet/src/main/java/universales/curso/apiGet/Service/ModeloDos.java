package universales.curso.apiGet.Service;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

@JsonIgnoreProperties(ignoreUnknown = true)
public class ModeloDos {
	 private Long id;
	  private String quote;

	  public ModeloDos() {
	  }

	  public Long getId() {
	    return this.id;
	  }

	  public String getQuote() {
	    return this.quote;
	  }

	  public void setId(Long id) {
	    this.id = id;
	  }

	  public void setQuote(String quote) {
	    this.quote = quote;
	  }

	  @Override
	  public String toString() {
	    return "Value{" +
	        "id=" + id +
	        ", quote='" + quote + '\'' +
	        '}';
	  }
}
