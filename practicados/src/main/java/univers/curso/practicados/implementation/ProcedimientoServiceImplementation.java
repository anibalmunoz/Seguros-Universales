package univers.curso.practicados.implementation;

import java.sql.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import univers.curso.practicados.dto.ProcedimientoDto;
import univers.curso.practicados.service.ProcedimientoService;
import univers.curso.practicados.ws.ProcedimientoServiceInterface;

@Component
public class ProcedimientoServiceImplementation implements ProcedimientoServiceInterface {

	@Autowired
	ProcedimientoService procedimientoService;

	@Override
	public int insertPoliza(Integer pNumeroPoliza, String pRamo, Date pFechaInicio, Date pFechaVencimiento,
			String pCondicionesParticulares, String pObservaciones, Integer pDniCl) {
		return procedimientoService.insertPoliza(pNumeroPoliza, pRamo, pFechaInicio, pFechaVencimiento, pCondicionesParticulares, pObservaciones, pDniCl);
	}
	
	@Override
	public ProcedimientoDto insertPolizaReturn(Integer pNumeroPoliza, String pRamo, Date pFechaInicio,
			Date pFechaVencimiento, String pCondicionesParticulares, String pObservaciones, Integer pDniCl) {
		return procedimientoService.insertPolizaReturn(pNumeroPoliza, pRamo, pFechaInicio, pFechaVencimiento, pCondicionesParticulares, pObservaciones, pDniCl);
	}

}
