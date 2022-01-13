package univers.curso.practicados.implementation;

import java.sql.Date;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;


import univers.curso.practicados.dto.SeguroDto;
import univers.curso.practicados.entity.Seguro;
import univers.curso.practicados.repository.SeguroRepository;
import univers.curso.practicados.ws.SeguroServiceInterface;

@Component
public class SeguroService implements SeguroServiceInterface {

	@Autowired
	SeguroRepository seguroRepository;

	@Override
	public List<Seguro> buscar() {
		return seguroRepository.findAll();
	}

	@Override
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

	@Override
	public void deleteSeguro(@PathVariable("numeroPoliza") Integer numeroPoliza) {
		Optional<Seguro> seguro;
		seguro = seguroRepository.findById(numeroPoliza);
		if (seguro.isPresent()) {
			seguroRepository.delete(seguro.get());
		}
	}

	@Override
	public List<Seguro> bucarFechaDespuesDe(@PathVariable Date fechaInicio) {
		return seguroRepository.findByFechaInicioAfter(fechaInicio);
	}
	
	//localhost:8080/seguro/buscar/fecha/despuesde/2010-10-09
	
}
