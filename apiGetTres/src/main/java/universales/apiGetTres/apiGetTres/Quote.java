package universales.apiGetTres.apiGetTres;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

@JsonIgnoreProperties(ignoreUnknown = true)
public class Quote {
	
	private int resultCount;

	  public int getResultCount() {
		return resultCount;
	}



	public void setResultCount(int resultCount) {
		this.resultCount = resultCount;
	}



	public Quote() {
	  }

	  
	  
	  @Override
	  public String toString() {
	    return "Quote{" +
	        "resultCount='" + resultCount + '\'' +	        
	        '}';
	  }
}
