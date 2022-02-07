package univers.curso.practicados.implementation;

import java.sql.Date;
import java.util.List;
import java.util.Optional;

import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

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
	public Seguro guardar(SeguroDto seguroDto) {
		Seguro seguro = convertirSeguroDtoASeguro(seguroDto);
		return seguroRepository.save(seguro);
	}

	private Seguro convertirSeguroDtoASeguro(SeguroDto seguroDto) {
		ModelMapper modelMapper = new ModelMapper();
		return modelMapper.map(seguroDto, Seguro.class);
	}

	@Override
	public void deleteSeguro(Integer numeroPoliza) {
		Optional<Seguro> seguro;
		seguro = seguroRepository.findById(numeroPoliza);
		if (seguro.isPresent()) {
			seguroRepository.delete(seguro.get());
		}
	}

	/*
	 * Consulta DSL
	 */
	
	@Override
	public List<Seguro> bucarFechaDespuesDe(Date fechaInicio) {
		return seguroRepository.findByFechaInicioAfter(fechaInicio);
	}

	// localhost:8080/seguro/buscar/fecha/despuesde/2010-10-09

}
