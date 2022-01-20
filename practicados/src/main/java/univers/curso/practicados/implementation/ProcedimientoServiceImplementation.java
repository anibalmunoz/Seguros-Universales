package univers.curso.practicados.implementation;

import java.sql.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import univers.curso.practicados.dto.FuncionDto;
import univers.curso.practicados.dto.ProcedimientoDto;
import univers.curso.practicados.dto.SeguroDto;
import univers.curso.practicados.entity.Seguro;
import univers.curso.practicados.service.ProcedimientoService;
import univers.curso.practicados.ws.ProcedimientoServiceInterface;

@Component
public class ProcedimientoServiceImplementation implements ProcedimientoServiceInterface {

	@Autowired
	ProcedimientoService procedimientoService;

	@Override
	public int insertPoliza(Integer pNumeroPoliza, String pRamo, Date pFechaInicio, Date pFechaVencimiento,
			String pCondicionesParticulares, String pObservaciones, Integer pDniCl) {
		return procedimientoService.insertPoliza(pNumeroPoliza, pRamo, pFechaInicio, pFechaVencimiento,
				pCondicionesParticulares, pObservaciones, pDniCl);
	}

	@Override
	public ProcedimientoDto insertPolizaReturn(Integer pNumeroPoliza, String pRamo, Date pFechaInicio,
			Date pFechaVencimiento, String pCondicionesParticulares, String pObservaciones, Integer pDniCl) {
		return procedimientoService.insertPolizaReturn(pNumeroPoliza, pRamo, pFechaInicio, pFechaVencimiento,
				pCondicionesParticulares, pObservaciones, pDniCl);
	}

	@Override
	public ProcedimientoDto insertPolizaReturnPost(SeguroDto seguroDto) {
		Seguro seguro = convertirSeguroDtoASeguro(seguroDto);
		return procedimientoService.insertPolizaReturnPost(seguro);
	}

	@Override
	public FuncionDto insertarSeguro(SeguroDto seguroDto) {
		Seguro seguro = convertirSeguroDtoASeguro(seguroDto);
		return procedimientoService.insertarSeguro(seguro);
	}

	private Seguro convertirSeguroDtoASeguro(SeguroDto seguroDto) {
		Seguro seguro = new Seguro();
		seguro.setNumeroPoliza(seguroDto.getNumeroPoliza());
		seguro.setRamo(seguroDto.getRamo());
		seguro.setFechaInicio(seguroDto.getFechaInicio());
		seguro.setFechaVencimiento(seguroDto.getFechaVencimiento());
		seguro.setCondicionesParticulares(seguroDto.getCondicionesParticulares());
		seguro.setObervaciones(seguroDto.getObervaciones());
		seguro.setDniCl(seguroDto.getDniCl());
		return seguro;
	}

	@Override
	public ProcedimientoDto obtenerNombre(Integer dniCl) {
		return procedimientoService.obtenerNombre(dniCl);
	}

}
