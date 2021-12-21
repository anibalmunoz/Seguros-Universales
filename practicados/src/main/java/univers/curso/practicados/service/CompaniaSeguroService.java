package univers.curso.practicados.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import univers.curso.practicados.entity.CompaniaSeguro;
import univers.curso.practicados.repository.CompaniaSeguroRepository;

@RestController
@RequestMapping("/companiaseguro")
@CrossOrigin
public class CompaniaSeguroService {

	@Autowired
	CompaniaSeguroRepository companiaSeguroRepository;
	
	@GetMapping(path = "/buscar")
	public List<CompaniaSeguro> buscar() {
		return companiaSeguroRepository.findAll();
	}
	
	
}
