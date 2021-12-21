package univers.curso.practicados.service;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import univers.curso.practicados.entity.Compania;
import univers.curso.practicados.repository.CompaniaRepository;

@RestController
@RequestMapping("/compania")
@CrossOrigin
public class CompaniaService {
	@Autowired
	CompaniaRepository companiaRepository;

	@GetMapping(path = "/buscar")
	public List<Compania> buscar() {
		return companiaRepository.findAll();
	}

	@PostMapping(path = "/guardar")
	public Compania guardar(@RequestBody Compania compania) {
		return companiaRepository.save(compania);
	}

	@DeleteMapping(path = "/eliminar/{nombreCompania}")
	public void deleteCompania(@PathVariable("nombreCompania") String nombreCompania) {

		Optional<Compania> compania;

		compania = companiaRepository.findById(nombreCompania);

		if (compania.isPresent()) {

			companiaRepository.delete(compania.get());
		}
		
	}
	
	@GetMapping(path = "/buscar/codigopostal/termina/{cadena}")
	public List<Compania> bucarContengaNumero(@PathVariable String cadena) {
		return companiaRepository.findByCodPostalEndingWith(cadena);

	}
}
