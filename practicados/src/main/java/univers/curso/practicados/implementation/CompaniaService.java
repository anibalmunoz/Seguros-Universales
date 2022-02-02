package univers.curso.practicados.implementation;

import java.util.List;
import java.util.Optional;

import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.library.dto.beans.CompaniaDto;

import univers.curso.practicados.entity.Compania;
import univers.curso.practicados.repository.CompaniaRepository;
import univers.curso.practicados.ws.CompaniaServiceInterface;

@Component
public class CompaniaService implements CompaniaServiceInterface {
	@Autowired
	CompaniaRepository companiaRepository;

	@Override
	public List<Compania> buscar() {
		return companiaRepository.findAll();
	}

	@Override
	public Compania guardar(CompaniaDto companiaDto) {
		Compania compania = convertirCompaniaDtoACompania(companiaDto);
		return companiaRepository.save(compania);
	}

	private Compania convertirCompaniaDtoACompania(CompaniaDto companiaDto) {
		ModelMapper modelMapper = new ModelMapper();
		return modelMapper.map(companiaDto, Compania.class);
	}

	@Override
	public void deleteCompania(String nombreCompania) {
		Optional<Compania> compania;
		compania = companiaRepository.findById(nombreCompania);
		if (compania.isPresent()) {
			companiaRepository.delete(compania.get());
		}
	}

	@Override
	public List<Compania> bucarContengaNumero(String cadena) {
		return companiaRepository.findByCodPostalEndingWith(cadena);

	}
}
