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

import com.library.dto.beans.CompaniaDto;

import univers.curso.practicados.entity.Compania;

@RestController
@RequestMapping("/compania")
@CrossOrigin
public interface CompaniaServiceInterface {

	@GetMapping(path = "/buscar")
	public List<Compania> buscar();

	@PostMapping(path = "/guardar")
	public Compania guardar(@RequestBody CompaniaDto companiaDto);

	@DeleteMapping(path = "/eliminar/{nombreCompania}")
	public void deleteCompania(@PathVariable("nombreCompania") String nombreCompania);

	@GetMapping(path = "/buscar/codigopostal/termina/{cadena}")
	public List<Compania> bucarContengaNumero(@PathVariable String cadena);

}
