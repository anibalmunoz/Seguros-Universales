package univers.curso.practicados.service;

import java.sql.Types;
import java.util.Date;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.SqlInOutParameter;
import org.springframework.jdbc.core.SqlOutParameter;
import org.springframework.jdbc.core.SqlParameter;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.jdbc.core.namedparam.SqlParameterSource;
import org.springframework.jdbc.core.simple.SimpleJdbcCall;
import org.springframework.stereotype.Service;

import univers.curso.practicados.dto.ProcedimientoDto;

@Service
public class ProcedimientoService {

	@Autowired
	NamedParameterJdbcTemplate namedParameterJdbcTemplate;

	@Autowired
	JdbcTemplate jdbcTemplate;

	/*
	 * Procedimiento almacenado
	 */
	public int insertPoliza(Integer pNumeroPoliza, String pRamo, Date pFechaInicio, Date pFechaVencimiento,
			String pCondicionesParticulares, String pObservaciones, Integer pDniCl) {
		String query = "BEGIN INSERT_SEGURO(:pNumeroPoliza, :pRamo, :pFechaInicio, :pFechaVencimiento, :pCondicionesParticulares, :pObservaciones, :pDniCl);"
				+ "END;";
		SqlParameterSource sqlParameterSource = new MapSqlParameterSource().addValue("pNumeroPoliza", pNumeroPoliza)
				.addValue("pRamo", pRamo).addValue("pFechaInicio", pFechaInicio)
				.addValue("pFechaVencimiento", pFechaVencimiento)
				.addValue("pCondicionesParticulares", pCondicionesParticulares)
				.addValue("pObservaciones", pObservaciones).addValue("pDniCl", pDniCl);
		return namedParameterJdbcTemplate.update(query, sqlParameterSource);
	}

	/*
	 * Procedimiento almacenado con IN, OUT E IN/OUT
	 */
	public ProcedimientoDto insertPolizaReturn(Integer pNumeroPoliza, String pRamo, Date pFechaInicio,
			Date pFechaVencimiento, String pCondicionesParticulares, String pObservaciones, Integer pDniCl) {
		SimpleJdbcCall simpleJdbcCall = new SimpleJdbcCall(jdbcTemplate);
		simpleJdbcCall.withProcedureName("INSERT_SEGURO_RETURN")
				// .withCatalogName("nombre_paquete").withSchemaName("nombre_usuario")
				.withoutProcedureColumnMetaDataAccess()
				.declareParameters(new SqlInOutParameter("P_NUMERO_POLIZA", Types.NUMERIC),
						new SqlParameter("P_RAMO", Types.VARCHAR), new SqlParameter("P_FECHA_INICIO", Types.DATE),
						new SqlParameter("P_FECHA_VENCIMIENTO", Types.DATE),
						new SqlParameter("P_CONDICIONES_PARTICULARES", Types.VARCHAR),
						new SqlParameter("P_OBSERVACIONES", Types.VARCHAR),
						new SqlInOutParameter("P_DNI_CL", Types.NUMERIC),
						new SqlOutParameter("P_NOMBRE_CL", Types.VARCHAR));
		
		SqlParameterSource sqlParameterSource = new MapSqlParameterSource().addValue("P_NUMERO_POLIZA", pNumeroPoliza)
				.addValue("P_RAMO", pRamo).addValue("P_FECHA_INICIO", pFechaInicio)
				.addValue("P_FECHA_VENCIMIENTO", pFechaVencimiento)
				.addValue("P_CONDICIONES_PARTICULARES", pCondicionesParticulares)
				.addValue("P_OBSERVACIONES", pObservaciones).addValue("P_DNI_CL", pDniCl);
		
		Map<String, Object> out = simpleJdbcCall.execute(sqlParameterSource);
		
		ProcedimientoDto dto = new ProcedimientoDto();
		dto.setpNumeroPoliza(pNumeroPoliza);
		dto.setpDniCl(pDniCl);
		dto.setpNombreCl((out.get("P_NOMBRE_CL").toString()));
		
		return dto;
		
	}
}
