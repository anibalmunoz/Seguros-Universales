package univers.curso.practicados.ws;

import java.sql.Date;
import java.util.List;
import java.util.Map;

import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import univers.curso.practicados.dto.SeguroDto;

import univers.curso.practicados.entity.Seguro;

@RestController
@RequestMapping("/seguro")
@CrossOrigin
public interface SeguroServiceInterface {

	@GetMapping(path = "/buscar")
	public List<Seguro> buscar();

	@GetMapping(path = "/buscar/porcliente/{dniCl}")
	public List<Map<String, Object>> buscarSegurosCliente(@PathVariable("dniCl") Integer dniCl);

	@PostMapping(path = "/guardar")
	public Seguro guardar(@RequestBody SeguroDto seguroDto);

	@DeleteMapping(path = "/eliminar/{numeroPoliza}")
	public void deleteSeguro(@PathVariable("numeroPoliza") Integer numeroPoliza);

	@GetMapping(path = "/buscar/fecha/despuesde/{fechaInicio}")
	public List<Seguro> bucarFechaDespuesDe(@PathVariable Date fechaInicio);

}
