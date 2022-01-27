package univers.curso.practicados.ws;

import java.util.List;

import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.library.dto.beans.PeritoDto;

import univers.curso.practicados.entity.Perito;

@RestController
@RequestMapping("/perito")
@CrossOrigin
public interface PeritoServiceInterface {

	@GetMapping(path = "/buscar")
	public List<Perito> buscar();

	@PostMapping(path = "/guardar")
	public Perito savePerito(@RequestBody PeritoDto peritoDto);

	@DeleteMapping(path = "/eliminar/{dniPerito}")
	public void deletePerito(@PathVariable("dniPerito") Integer dniPerito);
	
	/*
	 * Consultas DSL
	 */

	@GetMapping(path = "/buscar/apellido2/vacio")
	public List<Perito> apellido2Vacio();

	@GetMapping(path = "/buscar/apellido2/ocupado")
	public List<Perito> apellido2NoVacio();

}
