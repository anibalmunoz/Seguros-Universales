package univers.curso.practicados.implementation;

import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Component;

import univers.curso.practicados.dto.GroupByDto;
import univers.curso.practicados.dto.PeritoDto;

import univers.curso.practicados.entity.Perito;
import univers.curso.practicados.repository.PeritoRepository;
import univers.curso.practicados.ws.PeritoServiceInterface;

@Component
public class PeritoService implements PeritoServiceInterface {

	@Autowired
	PeritoRepository peritoRepository;

	@Override
	public List<Perito> buscar() {
		return peritoRepository.findAll();
	}

	@Override
	public ResponseEntity<Perito> savePerito(PeritoDto peritoDto) {
		Perito perito = convertirPeritoDtoAPerito(peritoDto);
		try {
			return new ResponseEntity<>(peritoRepository.save(perito), null, HttpStatus.OK);
		} catch (Exception ex) {
			return new ResponseEntity<>(null, null, HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}

	private Perito convertirPeritoDtoAPerito(PeritoDto peritoDto) {
		ModelMapper modelMapper = new ModelMapper();
		return modelMapper.map(peritoDto, Perito.class);
	}

	@Override
	public void deletePerito(Integer dniPerito) {
		Optional<Perito> perito;
		perito = peritoRepository.findById(dniPerito);
		if (perito.isPresent()) {
			peritoRepository.delete(perito.get());
		}
	}

	/*
	 * Consultas DSL
	 */

	@Override
	public List<Perito> apellido2Vacio() {
		return peritoRepository.findByApellidoPerito2IsNull();
	}

	@Override
	public List<Perito> apellido2NoVacio() {
		return peritoRepository.findByApellidoPerito2NotNull();
	}

	@Override
	public List<Object[]> prueba() {
		return peritoRepository.prueba();
	}

}
