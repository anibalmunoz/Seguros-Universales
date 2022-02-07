package univers.curso.practicados.implementation;

import java.util.List;
import java.util.Optional;

import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

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
	public Perito savePerito(PeritoDto peritoDto) {
		Perito perito = convertirPeritoDtoAPerito(peritoDto);
		return peritoRepository.save(perito);
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

}
