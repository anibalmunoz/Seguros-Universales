package univers.curso.practicados.ws;

import java.sql.Date;

import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import univers.curso.practicados.dto.ProcedimientoDto;

@RestController
@RequestMapping("/procedimiento")
@CrossOrigin
public interface ProcedimientoServiceInterface {

	@GetMapping(path = "/insert/poliza/{pNumeroPoliza}/{pRamo}/{pFechaInicio}/{pFechaVencimiento}/{pCondicionesParticulares}/{pObservaciones}/{pDniCl}")
	public int insertPoliza(@PathVariable Integer pNumeroPoliza, @PathVariable String pRamo,
			@PathVariable Date pFechaInicio, @PathVariable Date pFechaVencimiento,
			@PathVariable String pCondicionesParticulares, @PathVariable String pObservaciones,
			@PathVariable Integer pDniCl);

	@GetMapping(path = "/insert/poliza/return/{pNumeroPoliza}/{pRamo}/{pFechaInicio}/{pFechaVencimiento}/{pCondicionesParticulares}/{pObservaciones}/{pDniCl}")
	public ProcedimientoDto insertPolizaReturn(@PathVariable Integer pNumeroPoliza, @PathVariable String pRamo,
			@PathVariable Date pFechaInicio, @PathVariable Date pFechaVencimiento,
			@PathVariable String pCondicionesParticulares, @PathVariable String pObservaciones,
			@PathVariable Integer pDniCl);

}
