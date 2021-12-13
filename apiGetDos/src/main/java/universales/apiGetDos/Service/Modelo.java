package universales.apiGetDos.Service;




public class Modelo {
	private String artistName;
	private String trackName;
	
	public Modelo() {}
	
	public Modelo(String artistName, String trackName) {
		super();
		this.artistName=artistName;
		this.trackName=trackName;
	}

	public String getArtistName() {
		return artistName;
	}

	public void setArtistName(String artistName) {
		this.artistName = artistName;
	}

	public String getTrackName() {
		return trackName;
	}

	public void setTrackName(String trackName) {
		this.trackName = trackName;
	}
}
