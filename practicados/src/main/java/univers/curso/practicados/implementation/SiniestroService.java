package univers.curso.practicados.implementation;

import java.sql.Date;
import java.util.List;
import java.util.Optional;

import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
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
	public ResponseEntity<Siniestro> guardar(SiniestroDto siniestroDto) {
		Siniestro siniestro = convertirSiniestroDtoASiniestro(siniestroDto);
		try {
			return new ResponseEntity<>(siniestroRepository.save(siniestro), null, HttpStatus.OK);
		} catch (Exception ex) {
			return new ResponseEntity<>(null, null, HttpStatus.INTERNAL_SERVER_ERROR);
		}
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
	
	//Paginado
	
	public Page<Siniestro> buscarPaginado(int pagina, int cantidad){
		Pageable pageable = PageRequest.of(pagina, cantidad, Sort.by(Direction.ASC, "idSiniestro"));
		return siniestroRepository.findAll(pageable);
	}

}
