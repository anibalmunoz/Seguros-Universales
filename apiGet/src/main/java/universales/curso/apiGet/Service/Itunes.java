package universales.curso.apiGet.Service;

import java.io.Serializable;
import java.util.List;

import javax.annotation.Generated;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonPropertyOrder;

@JsonIgnoreProperties(ignoreUnknown = true)
@JsonInclude(JsonInclude.Include.NON_NULL)
@JsonPropertyOrder({ "resultCount", "results" })
@Generated("jsonchema2pojo")
public class Itunes implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = -792935144295449136L;
	@JsonProperty("resultCount")
	private Long resultCount;
	@JsonProperty("results")
	private List<Result> results = null;

	@JsonProperty("resultCount")
	public Long getResultCount() {
		return resultCount;
	}

	@JsonProperty("resultCount")
	public void setResultCount(Long resultCount) {
		this.resultCount = resultCount;
	}

	@JsonProperty("results")
	public List<Result> getResults() {
		return results;
	}

	@JsonProperty("results")
	public void setResutls(List<Result> results) {
		this.results = results;
	}

}
