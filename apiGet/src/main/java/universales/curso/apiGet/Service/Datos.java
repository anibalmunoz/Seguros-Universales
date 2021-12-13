package universales.curso.apiGet.Service;

import java.io.Serializable;

public class Datos implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 121L;

	/**
	 * Variables
	 */

	private String name;
	private String trackName;
	private String type;
	private String service;
	private String serviceUrl;

	/**
	 * Metodos
	 */

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getTrackName() {
		return trackName;
	}

	public void setTrackName(String trackName) {
		this.trackName = trackName;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getService() {
		return service;
	}

	public void setService(String service) {
		this.service = service;
	}

	public String getServiceUrl() {
		return serviceUrl;
	}

	public void setServiceUrl(String serviceUrl) {
		this.serviceUrl = serviceUrl;
	}

}
