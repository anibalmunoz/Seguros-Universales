package univers.curso.practicados.ws;

import java.util.List;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import univers.curso.practicados.entity.CompaniaSeguro;
import univers.curso.practicados.dto.CompaniaSeguroDto;

@RestController
@RequestMapping("/companiaseguro")
@CrossOrigin
public interface CompaniaSeguroServiceInterface {

	@GetMapping(path = "/buscar")
	public List<CompaniaSeguro> buscar();
	
	@PostMapping(path = "/guardar")
	public ResponseEntity<CompaniaSeguro> guardar(@RequestBody CompaniaSeguroDto companiaSeguroDto);
	
	@DeleteMapping(path = "/eliminar/{id}")
	public void eliminar(@PathVariable("id") Integer id);


}
