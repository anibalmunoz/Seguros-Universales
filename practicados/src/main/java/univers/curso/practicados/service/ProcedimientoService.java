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

import com.library.dto.beans.FuncionDto;
import com.library.dto.beans.ProcedimientoDto;

import univers.curso.practicados.entity.Seguro;

@Service
public class ProcedimientoService {

	/*
	 * Parametros de la tabla Seguro
	 */
	static final String P_FECHA_INICIO = "P_FECHA_INICIO";
	static final String P_FECHA_VENCIMIENTO = "P_FECHA_VENCIMIENTO";
	static final String P_CONDICIONES_PARTICULARES = "P_CONDICIONES_PARTICULARES";
	static final String P_DNI_CL = "P_DNI_CL";
	static final String P_NUMERO_POLIZA = "P_NUMERO_POLIZA";
	static final String P_OBSERVACIONES = "P_OBSERVACIONES";
	static final String P_RAMO = "P_RAMO";
	/*
	 * parametros de la tabal Cliente
	 */
	static final String P_NOMBRE_CL = "P_NOMBRE_CL";

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
		simpleJdbcCall.withProcedureName("INSERT_SEGURO_RETURN").withoutProcedureColumnMetaDataAccess()
				.declareParameters(new SqlInOutParameter(P_NUMERO_POLIZA, Types.NUMERIC),
						new SqlParameter(P_RAMO, Types.VARCHAR), new SqlParameter(P_FECHA_INICIO, Types.DATE),
						new SqlParameter(P_FECHA_VENCIMIENTO, Types.DATE),
						new SqlParameter(P_CONDICIONES_PARTICULARES, Types.VARCHAR),
						new SqlParameter(P_OBSERVACIONES, Types.VARCHAR),
						new SqlInOutParameter(P_DNI_CL, Types.NUMERIC),
						new SqlOutParameter(P_NOMBRE_CL, Types.VARCHAR));

		SqlParameterSource sqlParameterSource = new MapSqlParameterSource().addValue(P_NUMERO_POLIZA, pNumeroPoliza)
				.addValue(P_RAMO, pRamo).addValue(P_FECHA_INICIO, pFechaInicio)
				.addValue(P_FECHA_VENCIMIENTO, pFechaVencimiento)
				.addValue(P_CONDICIONES_PARTICULARES, pCondicionesParticulares)
				.addValue(P_OBSERVACIONES, pObservaciones).addValue(P_DNI_CL, pDniCl);

		Map<String, Object> out = simpleJdbcCall.execute(sqlParameterSource);

		ProcedimientoDto dto = new ProcedimientoDto();
		dto.setpNumeroPoliza(pNumeroPoliza);
		dto.setpDniCl(pDniCl);
		dto.setpNombreCl((out.get(P_NOMBRE_CL).toString()));

		return dto;

	}

	/*
	 * Procedimiento almacenado con IN, OUT E IN/OUT con metodo post
	 */
	public ProcedimientoDto insertPolizaReturnPost(Seguro seguro) {

		SimpleJdbcCall simpleJdbcCall = new SimpleJdbcCall(jdbcTemplate);
		simpleJdbcCall.withProcedureName("INSERT_SEGURO_RETURN").withoutProcedureColumnMetaDataAccess()
				.declareParameters(new SqlOutParameter(P_NUMERO_POLIZA, Types.INTEGER),
						new SqlParameter(P_RAMO, Types.VARCHAR), new SqlParameter(P_FECHA_INICIO, Types.DATE),
						new SqlParameter(P_FECHA_VENCIMIENTO, Types.DATE),
						new SqlParameter(P_CONDICIONES_PARTICULARES, Types.VARCHAR),
						new SqlParameter(P_OBSERVACIONES, Types.VARCHAR),
						new SqlInOutParameter(P_DNI_CL, Types.INTEGER),
						new SqlOutParameter(P_NOMBRE_CL, Types.VARCHAR));

		SqlParameterSource sqlParameterSource = new MapSqlParameterSource().addValue(P_RAMO, seguro.getRamo())
				.addValue(P_FECHA_INICIO, seguro.getFechaInicio())
				.addValue(P_FECHA_VENCIMIENTO, seguro.getFechaVencimiento())
				.addValue(P_CONDICIONES_PARTICULARES, seguro.getCondicionesParticulares())
				.addValue(P_OBSERVACIONES, seguro.getObervaciones()).addValue(P_DNI_CL, seguro.getDniCl());

		Map<String, Object> out = simpleJdbcCall.execute(sqlParameterSource);

		ProcedimientoDto dto = new ProcedimientoDto();
		dto.setpNumeroPoliza(Integer.parseInt(out.get(P_NUMERO_POLIZA).toString()));
		dto.setpDniCl(seguro.getDniCl());
		dto.setpNombreCl((out.get(P_NOMBRE_CL).toString()));

		return dto;

	}

	/*
	 * Funcion en paquete
	 */
	public FuncionDto insertarSeguro(Seguro seguro) {

		SimpleJdbcCall simpleJdbcCall = new SimpleJdbcCall(jdbcTemplate);
		simpleJdbcCall.withFunctionName("INSERTAR_SEGURO").withCatalogName("PAQUETE").withSchemaName("practicados")
				.declareParameters(new SqlParameter(P_NUMERO_POLIZA, Types.INTEGER),
						new SqlParameter(P_RAMO, Types.VARCHAR), new SqlParameter(P_FECHA_INICIO, Types.DATE),
						new SqlParameter(P_FECHA_VENCIMIENTO, Types.DATE),
						new SqlParameter(P_CONDICIONES_PARTICULARES, Types.VARCHAR),
						new SqlParameter(P_OBSERVACIONES, Types.VARCHAR), new SqlParameter(P_DNI_CL, Types.INTEGER),
						new SqlOutParameter("POLIZA", Types.INTEGER));
		SqlParameterSource sqlParameterSource = new MapSqlParameterSource()
				.addValue(P_NUMERO_POLIZA, seguro.getNumeroPoliza()).addValue(P_RAMO, seguro.getRamo())
				.addValue(P_FECHA_INICIO, seguro.getFechaInicio())
				.addValue(P_FECHA_VENCIMIENTO, seguro.getFechaVencimiento())
				.addValue(P_CONDICIONES_PARTICULARES, seguro.getCondicionesParticulares())
				.addValue(P_OBSERVACIONES, seguro.getObervaciones()).addValue(P_DNI_CL, seguro.getDniCl());
		Integer out = simpleJdbcCall.executeFunction(Integer.class, sqlParameterSource);
		FuncionDto dto = new FuncionDto();
		dto.setpNumeroPoliza(out);

		return dto;
	}

	/*
	 * Función de prueba de uso de funciones
	 */
	public ProcedimientoDto obtenerNombre(Integer dniCl) {

		SimpleJdbcCall simpleJdbcCall = new SimpleJdbcCall(jdbcTemplate);
		simpleJdbcCall.withFunctionName("OBTENER_NOMBRE").declareParameters(new SqlParameter(P_DNI_CL, Types.INTEGER),
				new SqlOutParameter("NOMBRE", Types.VARCHAR));
		SqlParameterSource sqlParameterSource = new MapSqlParameterSource().addValue(P_DNI_CL, dniCl);
		String out = simpleJdbcCall.executeFunction(String.class, sqlParameterSource);
		ProcedimientoDto dto = new ProcedimientoDto();
		dto.setpNombreCl(out);

		return dto;

	}
}
