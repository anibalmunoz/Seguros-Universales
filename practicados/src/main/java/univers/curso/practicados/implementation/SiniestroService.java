package univers.curso.practicados.implementation;

import java.sql.Date;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

import com.library.dto.beans.SiniestroDto;

import univers.curso.practicados.entity.Siniestro;
import univers.curso.practicados.repository.SiniestroRepository;
import univers.curso.practicados.ws.SiniestroServiceInterface;

@Component
public class SiniestroService implements SiniestroServiceInterface{

	@Autowired
	SiniestroRepository siniestroRepository;

	@GetMapping(path = "/buscar")
	public List<Siniestro> buscar() {
		return siniestroRepository.findAll();
	}

	@PostMapping(path = "/guardar")
	public Siniestro guardar(@RequestBody SiniestroDto siniestroDto) {
		Siniestro siniestro = convertirSiniestroDtoASiniestro(siniestroDto);
		return siniestroRepository.save(siniestro);
	}

	private Siniestro convertirSiniestroDtoASiniestro(SiniestroDto siniestroDto) {
		Siniestro siniestro = new Siniestro();
		siniestro.setIdSiniestro(siniestroDto.getIdSiniestro());
		siniestro.setFechaSiniestro(siniestroDto.getFechaSiniestro());
		siniestro.setCausas(siniestroDto.getCausas());
		siniestro.setAceptado(siniestroDto.getAceptado());
		siniestro.setIndemnizacion(siniestroDto.getIndemnizacion());
		siniestro.setNumeroPoliza(siniestroDto.getNumeroPoliza());
		return siniestro;
	}

	@DeleteMapping(path = "/eliminar/{idSiniestro}")
	public void deleteSiniestro(@PathVariable("idSiniestro") Integer idSiniestro) {
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

	// localhost:8080/siniestro/buscar/fecha/antesde/2010-10-09

}
