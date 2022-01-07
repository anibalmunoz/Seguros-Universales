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

import univers.curso.practicados.dto.SeguroDto;
import univers.curso.practicados.entity.Seguro;
import univers.curso.practicados.repository.SeguroRepository;

@RestController
@RequestMapping("/seguro")
@CrossOrigin
public class SeguroService {

	@Autowired
	SeguroRepository seguroRepository;

	@GetMapping(path = "/buscar")
	public List<Seguro> buscar() {
		return seguroRepository.findAll();
	}

	@PostMapping(path = "/guardar")
	public Seguro guardar(@RequestBody SeguroDto seguroDto) {
		Seguro seguro=convertirSeguroDtoASeguro(seguroDto);
		return seguroRepository.save(seguro);
	}

	private Seguro convertirSeguroDtoASeguro(SeguroDto seguroDto) {
		Seguro seguro = new Seguro();
		seguro.setNumeroPoliza(seguroDto.getNumeroPoliza());
		seguro.setRamo(seguroDto.getRamo());
		seguro.setFechaInicio(seguroDto.getFechaInicio());
		seguro.setFechaVencimiento(seguroDto.getFechaVencimiento());
		seguro.setCondicionesParticulares(seguroDto.getCondicionesParticulares());
		seguro.setObervaciones(seguroDto.getObervaciones());
		seguro.setDniCl(seguroDto.getDniCl());
		return seguro;
	}

	@DeleteMapping(path = "/eliminar/{numeroPoliza}")
	public void deleteSeguro(@PathVariable("numeroPoliza") Integer numeroPoliza) {
		Optional<Seguro> seguro;
		seguro = seguroRepository.findById(numeroPoliza);
		if (seguro.isPresent()) {
			seguroRepository.delete(seguro.get());
		}
	}

	@GetMapping(path = "/buscar/fecha/despuesde/{fechaInicio}")
	public List<Seguro> bucarFechaDespuesDe(@PathVariable Date fechaInicio) {
		return seguroRepository.findByFechaInicioAfter(fechaInicio);
	}
	
	//localhost:8080/seguro/buscar/fecha/despuesde/2010-10-09
	
}
