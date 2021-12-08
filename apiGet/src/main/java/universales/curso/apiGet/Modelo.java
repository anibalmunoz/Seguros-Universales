package universales.curso.apiGet;

import java.io.Serializable;

import com.fasterxml.jackson.annotation.JsonProperty;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

@JsonIgnoreProperties(ignoreUnknown = true)

public class Modelo implements Serializable{
	
	private static final long serialVersionUID = 4676905652686424400L;

	/** The id. */
	@JsonProperty("postId")
	private Integer postId;

	/** The title. */
	private Integer id;

	/** The author. */
	private String name;

	/** The content. */
	private String email;

	/** The publisher. */
	private String body;

	/**
	 * Gets the post id.
	 *
	 * @return the post id
	 */
	public Integer getPostId() {
		return postId;
	}

	/**
	 * Sets the post id.
	 *
	 * @param postId the new post id
	 */
	public void setPostId(Integer postId) {
		this.postId = postId;
	}

	/**
	 * Gets the id.
	 *
	 * @return the id
	 */
	public Integer getId() {
		return id;
	}

	/**
	 * Sets the id.
	 *
	 * @param id the new id
	 */
	public void setId(Integer id) {
		this.id = id;
	}

	/**
	 * Gets the name.
	 *
	 * @return the name
	 */
	public String getName() {
		return name;
	}

	/**
	 * Sets the name.
	 *
	 * @param name the new name
	 */
	public void setName(String name) {
		this.name = name;
	}

	/**
	 * Gets the email.
	 *
	 * @return the email
	 */
	public String getEmail() {
		return email;
	}

	/**
	 * Sets the email.
	 *
	 * @param email the new email
	 */
	public void setEmail(String email) {
		this.email = email;
	}

	/**
	 * Gets the body.
	 *
	 * @return the body
	 */
	public String getBody() {
		return body;
	}

	/**
	 * Sets the body.
	 *
	 * @param body the new body
	 */
	public void setBody(String body) {
		this.body = body;
	}

	/**
	 * Instantiates a new open place holder model.
	 */
	public Modelo() {
		super();
	}

	/**
	 * To string.
	 *
	 * @return the string
	 */
	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("OpenPlaceHolderModel [postId=");
		builder.append(postId);
		builder.append(", id=");
		builder.append(id);
		builder.append(", name=");
		builder.append(name);
		builder.append(", email=");
		builder.append(email);
		builder.append(", body=");
		builder.append(body);
		builder.append("]");
		return builder.toString();
	}

}
