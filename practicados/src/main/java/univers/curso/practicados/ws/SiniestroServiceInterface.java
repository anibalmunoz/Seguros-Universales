package univers.curso.practicados.ws;

import java.sql.Date;
import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import univers.curso.practicados.dto.SiniestroDto;
import univers.curso.practicados.entity.Siniestro;
@RestController
@RequestMapping("/siniestro")
@CrossOrigin
public interface SiniestroServiceInterface {

	@GetMapping(path = "/buscar")
	public List<Siniestro> buscar();
	
	
	
	@GetMapping(path = "/buscar/dni/{idSiniestro}")
	public List<Siniestro> buscarId(@PathVariable Integer idSiniestro);
	

	@PostMapping(path = "/guardar")
	public ResponseEntity<Siniestro> guardar(@RequestBody SiniestroDto siniestroDto);

	@DeleteMapping(path = "/eliminar/{idSiniestro}")
	public void deleteSiniestro(@PathVariable("idSiniestro") Integer idSiniestro);
	
	/*
	 * Consultas DSL
	 */

	@GetMapping(path = "/buscar/numeropoliza/mayor/{numeroPoliza}")
	public List<Siniestro> bucarMayorQue(@PathVariable("numeroPoliza") Integer numeroPoliza);

	@GetMapping(path = "/buscar/numeropoliza/menor/{numeroPoliza}")
	public List<Siniestro> bucarMenorQue(@PathVariable("numeroPoliza") Integer numeroPoliza);

	@GetMapping(path = "/buscar/fecha/antesde/{fechaSiniestro}")
	public List<Siniestro> bucarFechaDespuesDe(@PathVariable Date fechaSiniestro);
	
	//Paginador de siniestros
	
	@GetMapping(path = "/paginado/{pagina}/{cantidad}")
	public Page<Siniestro> buscarPaginado(@PathVariable("pagina") int pagina, @ PathVariable("cantidad") int cantidad);
	
	

}
