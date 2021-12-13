package universales.curso.apiGet.Service;

import java.io.Serializable;

public class DatosPropuestos implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 121L;

	/**
	 * Variables
	 */

	private String name;
	private String type;
	private String language;
	private String service;
	private String serviceUrl;
	private String vistaPrevia;

	public String getVistaPrevia() {
		return vistaPrevia;
	}

	public void setVistaPrevia(String vistaPrevia) {
		this.vistaPrevia = vistaPrevia;
	}

	public String getLanguage() {
		return language;
	}

	public void setLanguage(String language) {
		this.language = language;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
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
