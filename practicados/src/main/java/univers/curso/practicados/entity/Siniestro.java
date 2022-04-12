package univers.curso.practicados.entity;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.SequenceGenerator;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import lombok.Data;

@Entity
@SequenceGenerator(name = "sqcSiniestro", sequenceName = "SQC_SINIESTRO", allocationSize = 1)
@Data
public class Siniestro implements Serializable {

	private static final long serialVersionUID = 1016402528707777371L;

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "sqcSiniestro")
	@Column(name = "ID_SINIESTRO")
	private Integer idSiniestro;

	@Temporal(TemporalType.DATE)
	@Column(name = "FECHA_SINIESTRO")
	private Date fechaSiniestro;

	@Column(name = "CAUSAS")
	private String causas;

	@Column(name = "ACEPTADO")
	private String aceptado;

	@Column(name = "INDEMNIZACION")
	private String indemnizacion;

	@Column(name = "NUMERO_POLIZA")
	private Integer numeroPoliza;

	@ManyToOne()
	@JoinColumn(name = "DNI_PERITO")
	private Perito perito;

}
