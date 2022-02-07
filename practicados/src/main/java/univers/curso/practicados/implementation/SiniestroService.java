package univers.curso.practicados.implementation;

import java.sql.Date;
import java.util.List;
import java.util.Optional;

import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import univers.curso.practicados.dto.SiniestroDto;

import univers.curso.practicados.entity.Siniestro;
import univers.curso.practicados.repository.SiniestroRepository;
import univers.curso.practicados.ws.SiniestroServiceInterface;

@Component
public class SiniestroService implements SiniestroServiceInterface {

	@Autowired
	SiniestroRepository siniestroRepository;

	@Override
	public List<Siniestro> buscar() {
		return siniestroRepository.findAll();
	}

	@Override
	public Siniestro guardar(SiniestroDto siniestroDto) {
		Siniestro siniestro = convertirSiniestroDtoASiniestro(siniestroDto);
		return siniestroRepository.save(siniestro);
	}

	private Siniestro convertirSiniestroDtoASiniestro(SiniestroDto siniestroDto) {
		ModelMapper modelMapper = new ModelMapper();
		return modelMapper.map(siniestroDto, Siniestro.class);
	}

	@Override
	public void deleteSiniestro(Integer idSiniestro) {
		Optional<Siniestro> siniestro;
		siniestro = siniestroRepository.findById(idSiniestro);
		if (siniestro.isPresent()) {
			siniestroRepository.delete(siniestro.get());
		}
	}

	/*
	 * Consultas DSL
	 */

	@Override
	public List<Siniestro> bucarMayorQue(Integer numeroPoliza) {
		return siniestroRepository.findByNumeroPolizaGreaterThanEqual(numeroPoliza);
	}

	@Override
	public List<Siniestro> bucarMenorQue(Integer numeroPoliza) {
		return siniestroRepository.findByNumeroPolizaLessThanEqual(numeroPoliza);
	}

	@Override
	public List<Siniestro> bucarFechaDespuesDe(Date fechaSiniestro) {
		return siniestroRepository.findByFechaSiniestroBefore(fechaSiniestro);
	}

	// localhost:8080/siniestro/buscar/fecha/antesde/2010-10-09

}
