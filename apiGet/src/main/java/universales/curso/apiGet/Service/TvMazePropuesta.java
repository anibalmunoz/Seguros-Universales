package universales.curso.apiGet.Service;

import java.io.Serializable;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonProperty;
@JsonIgnoreProperties(ignoreUnknown = true)
public class TvMazePropuesta implements Serializable {

	private static final long serialVersionUID = 1;
	@JsonProperty("score")
	private double score;
	
	@JsonProperty("show")
	private	Show show;

	public double getScore() {
		return score;
	}

	public void setScore(double score) {
		this.score = score;
	}

	public Show getShow() {
		return show;
	}

	public void setShow(Show show) {
		this.show = show;
	}


	
	
}
