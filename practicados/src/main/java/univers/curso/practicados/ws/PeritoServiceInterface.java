package univers.curso.practicados.ws;

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

import univers.curso.practicados.dto.PeritoDto;
import univers.curso.practicados.entity.Perito;

@RestController
@RequestMapping("/perito")
@CrossOrigin
public interface PeritoServiceInterface {

	@GetMapping(path = "/buscar")
	public List<Perito> buscar();
	/*
	 * Buscar por DNI
	 */
	
	@GetMapping(path = "/buscar/dni/{dniPerito}")
	public List<Perito> buscarDni(@PathVariable Integer dniPerito);
	
	/*
	 * 
	 */
	@PostMapping(path = "/guardar")
	public ResponseEntity<Perito> savePerito(@RequestBody PeritoDto peritoDto);

	@DeleteMapping(path = "/eliminar/{dniPerito}")
	public void deletePerito(@PathVariable("dniPerito") Integer dniPerito);
	
	/*
	 * Consultas DSL
	 */

	@GetMapping(path = "/buscar/apellido2/vacio")
	public List<Perito> apellido2Vacio();

	@GetMapping(path = "/buscar/apellido2/ocupado")
	public List<Perito> apellido2NoVacio();
	
	@GetMapping(path="/prueba")
	public List<Object[]> prueba();
	
	//Paginado
	@GetMapping(path = "/paginado/{pagina}/{cantidad}")
	public Page<Perito> buscarPaginado(@PathVariable("pagina") int pagina, @ PathVariable("cantidad") int cantidad);
	
	@GetMapping(path = "/paginado/{pagina}/{cantidad}/{nombrePerito}")
	public Page<Perito> buscarPaginadoNombre(@PathVariable("pagina") int pagina,
			@PathVariable("cantidad") int cantidad, @PathVariable("nombrePerito") String nombrePerito);

}
