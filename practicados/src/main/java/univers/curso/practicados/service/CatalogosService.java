package univers.curso.practicados.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.jdbc.core.namedparam.SqlParameterSource;
import org.springframework.stereotype.Service;

@Service
public class CatalogosService {

	static final String DNI = "dniCl";
	static final String NOMBRE = "nombreCl";

	@Autowired
	NamedParameterJdbcTemplate namedParameterJdbcTemplate;

	/*
	 * Querys de Cliente
	 * 
	 */

	public List<Map<String, Object>> buscarClientes() {
		String query = "SELECT DNI_CL, NOMBRE_CL FROM CLIENTE";
		SqlParameterSource sqlParameterSource = new MapSqlParameterSource();
		return namedParameterJdbcTemplate.queryForList(query, sqlParameterSource);
	}

	public List<Map<String, Object>> buscarCliente(Integer dniCl) {
		String query = "SELECT DNI_CL, NOMBRE_CL FROM CLIENTE WHERE DNI_CL = :dniCl";
		SqlParameterSource sqlParameterSource = new MapSqlParameterSource().addValue(DNI, dniCl);
		return namedParameterJdbcTemplate.queryForList(query, sqlParameterSource);
	}

	public void cambiarNombre(Integer dniCl, String nombreCl) {
		String query = "update CLIENTE set NOMBRE_CL= :nombreCl where DNI_CL = :dniCl";
		SqlParameterSource sqlParameterSource = new MapSqlParameterSource().addValue(DNI, dniCl).addValue(NOMBRE,
				nombreCl);
		namedParameterJdbcTemplate.update(query, sqlParameterSource);
	}

	
	public List<Map<String,Object>> buscarPolizasCliente(Integer dniCl){
		String query = "SELECT NUMERO_POLIZA , FECHA_INICIO , FECHA_VENCIMIENTO FROM SEGURO WHERE DNI_CL = :dniCl";
		SqlParameterSource sqlParameterSource =  new MapSqlParameterSource().addValue(DNI, dniCl);
		return namedParameterJdbcTemplate.queryForList(query, sqlParameterSource);
	}
	
	/*
	 * Insert
	 */
	public int insertCliente(Integer dniCl, String nombreCl, String apellido1, String codPostal, String ciudad,
			Integer telefono, String observaciones) {
		String query = "INSERT INTO CLIENTE (DNI_CL,NOMBRE_CL, APELLIDO_1,COD_POSTAL,CIUDAD,TELEFONO,OBSERVACIONES)\r\n"
				+ "VALUES(:dniCl,:nombreCl,:apellido1,:codPostal,:ciudad,:telefono,:observaciones)";
		SqlParameterSource sqlParameterSource = new MapSqlParameterSource().addValue(DNI, dniCl)
				.addValue(NOMBRE, nombreCl).addValue("apellido1", apellido1).addValue("codPostal", codPostal)
				.addValue("ciudad", ciudad).addValue("telefono", telefono).addValue("observaciones", observaciones);
		return namedParameterJdbcTemplate.update(query, sqlParameterSource);
	}

	/*
	 * Update
	 */
	public int cambiarNombreInt(Integer dniCl, String nombreCl) {
		String query = "update CLIENTE set NOMBRE_CL= :nombreCl where DNI_CL = :dniCl";
		SqlParameterSource sqlParameterSource = new MapSqlParameterSource().addValue(DNI, dniCl).addValue(NOMBRE,
				nombreCl);
		return namedParameterJdbcTemplate.update(query, sqlParameterSource);
	}

	
	
	
	
	/*
	 * Delete
	 */
	public int deleteCliente(Integer dniCl) {
		String query = "delete from CLIENTE where DNI_CL=:dniCl";
		SqlParameterSource sqlParameterSource = new MapSqlParameterSource().addValue(DNI, dniCl);
		return namedParameterJdbcTemplate.update(query, sqlParameterSource);
	}

	/*
	 * Select
	 */
	public List<Map<String, Object>> selectClienteSeguro(String fechaInicio, String fechaVencimiento) {
		String query = "SELECT CLI.NOMBRE_CL, CLI.APELLIDO_1, CLI.TELEFONO, SEG.NUMERO_POLIZA, SEG.FECHA_INICIO, SEG.FECHA_VENCIMIENTO FROM SEGURO SEG \r\n"
				+ "INNER JOIN CLIENTE CLI ON CLI.DNI_CL = SEG.DNI_CL \r\n"
				+ "WHERE FECHA_VENCIMIENTO BETWEEN TO_DATE (:fechaInicio,'DD/MM/YY') AND TO_DATE(:fechaVencimiento,'DD/MM/YY')";
		SqlParameterSource sqlParameterSource = new MapSqlParameterSource().addValue("fechaInicio", fechaInicio)
				.addValue("fechaVencimiento", fechaVencimiento);
		return namedParameterJdbcTemplate.queryForList(query, sqlParameterSource);			
		//localhost:8080/cliente/select/poliza/01-01-2021/31-12-2026
	}

}
