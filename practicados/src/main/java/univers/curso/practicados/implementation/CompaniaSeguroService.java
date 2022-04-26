package univers.curso.practicados.implementation;

import java.util.List;
import java.util.Optional;

import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Component;

import univers.curso.practicados.dto.CompaniaSeguroDto;
import univers.curso.practicados.entity.CompaniaSeguro;
import univers.curso.practicados.repository.CompaniaSeguroRepository;
import univers.curso.practicados.ws.CompaniaSeguroServiceInterface;

@Component
public class CompaniaSeguroService implements CompaniaSeguroServiceInterface {

	@Autowired
	CompaniaSeguroRepository companiaSeguroRepository;

	@Override
	public List<CompaniaSeguro> buscar() {
		return companiaSeguroRepository.findAll();
	}

	@Override
	public ResponseEntity<CompaniaSeguro> guardar(CompaniaSeguroDto companiaSeguroDto) {
		CompaniaSeguro compseg = convertirCompSegADto(companiaSeguroDto);
		try {
			return new ResponseEntity<>(companiaSeguroRepository.save(compseg), null, HttpStatus.OK);
		} catch (Exception ex) {
			return new ResponseEntity<>(null, null, HttpStatus.INTERNAL_SERVER_ERROR);
		}

	}

	@Override
	public void eliminar(Integer id) {

		Optional<CompaniaSeguro> compseg;
		compseg = companiaSeguroRepository.findById(id);
		if (compseg.isPresent()) {
			companiaSeguroRepository.delete(compseg.get());
		}

	}

	private CompaniaSeguro convertirCompSegADto(CompaniaSeguroDto companiaSeguroDto) {
		ModelMapper modelMapper = new ModelMapper();
		return modelMapper.map(companiaSeguroDto, CompaniaSeguro.class);
	}

}
