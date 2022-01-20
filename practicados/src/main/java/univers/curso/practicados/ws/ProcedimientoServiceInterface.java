package univers.curso.practicados.ws;

import java.sql.Date;

import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import univers.curso.practicados.dto.FuncionDto;
import univers.curso.practicados.dto.ProcedimientoDto;
import univers.curso.practicados.dto.SeguroDto;

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
	
	@PostMapping(path="/insertar/seguro/procedimiento")
	public ProcedimientoDto insertPolizaReturnPost(@RequestBody SeguroDto seguroDto);
	
	@PostMapping(path = "/insertar/seguro")
	public FuncionDto insertarSeguro(@RequestBody SeguroDto seguroDto);
	
	/*Funcion de prueba*/
	
	@GetMapping(path="/obtener/nombre/{dniCl}")
	public ProcedimientoDto obtenerNombre(@PathVariable Integer dniCl);

}
