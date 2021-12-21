package univers.curso.practicados.service;

import java.sql.Date;
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

import univers.curso.practicados.entity.Siniestro;
import univers.curso.practicados.repository.SiniestroRepository;

@RestController
@RequestMapping("/siniestro")
@CrossOrigin
public class SiniestroService {

	@Autowired
	SiniestroRepository siniestroRepository;

	@GetMapping(path = "/buscar")
	public List<Siniestro> buscar() {
		return siniestroRepository.findAll();
	}

	@PostMapping(path = "/guardar")
	public Siniestro guardar(@RequestBody Siniestro siniestro) {
		return siniestroRepository.save(siniestro);
	}

	@DeleteMapping(path = "/eliminar/{idSiniestro}")
	public void deleteCompania(@PathVariable("idSiniestro") Integer idSiniestro) {
		Optional<Siniestro> siniestro;
		siniestro = siniestroRepository.findById(idSiniestro);
		if (siniestro.isPresent()) {
			siniestroRepository.delete(siniestro.get());
		}
	}

	@GetMapping(path = "/buscar/numeropoliza/mayor/{numeroPoliza}")
	public List<Siniestro> bucarMayorQue(@PathVariable("numeroPoliza") Integer numeroPoliza) {
		return siniestroRepository.findByNumeroPolizaGreaterThanEqual(numeroPoliza);
	}
	
	@GetMapping(path = "/buscar/numeropoliza/menor/{numeroPoliza}")
	public List<Siniestro> bucarMenorQue(@PathVariable("numeroPoliza") Integer numeroPoliza) {
		return siniestroRepository.findByNumeroPolizaLessThanEqual(numeroPoliza);
	}
	
	@GetMapping(path = "/buscar/fecha/antesde/{fechaSiniestro}")
	public List<Siniestro> bucarFechaDespuesDe(@PathVariable Date fechaSiniestro) {
		return siniestroRepository.findByFechaSiniestroBefore(fechaSiniestro);
	}
	
	//localhost:8080/siniestro/buscar/fecha/antesde/2010-10-09

	
}
