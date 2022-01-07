package univers.curso.practicados.dto;

import java.io.Serializable;
import java.util.Date;
import java.util.Set;

import univers.curso.practicados.entity.Compania;

public class SeguroDto implements Serializable{

		private static final long serialVersionUID = -4333012104927311458L;
		
		private Integer numeroPoliza;
		private String ramo;
		private Date fechaInicio;
		private Date fechaVencimiento;
		private String condicionesParticulares;
		private String obervaciones;
		private Integer dniCl;
		
		private Set<Compania> companias;

		public Integer getNumeroPoliza() {
			return numeroPoliza;
		}

		public void setNumeroPoliza(Integer numeroPoliza) {
			this.numeroPoliza = numeroPoliza;
		}

		public String getRamo() {
			return ramo;
		}

		public void setRamo(String ramo) {
			this.ramo = ramo;
		}

		public Date getFechaInicio() {
			return fechaInicio;
		}

		public void setFechaInicio(Date fechaInicio) {
			this.fechaInicio = fechaInicio;
		}

		public Date getFechaVencimiento() {
			return fechaVencimiento;
		}

		public void setFechaVencimiento(Date fechaVencimiento) {
			this.fechaVencimiento = fechaVencimiento;
		}

		public String getCondicionesParticulares() {
			return condicionesParticulares;
		}

		public void setCondicionesParticulares(String condicionesParticulares) {
			this.condicionesParticulares = condicionesParticulares;
		}

		public String getObervaciones() {
			return obervaciones;
		}

		public void setObervaciones(String obervaciones) {
			this.obervaciones = obervaciones;
		}

		public Integer getDniCl() {
			return dniCl;
		}

		public void setDniCl(Integer dniCl) {
			this.dniCl = dniCl;
		}

		public Set<Compania> getCompanias() {
			return companias;
		}

		public void setCompanias(Set<Compania> companias) {
			this.companias = companias;
		}



}
