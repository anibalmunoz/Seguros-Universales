package univers.curso.practicados.implementation;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;

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
	public Compania guardar(@RequestBody CompaniaDto companiaDto) {
		Compania compania = convertirCompaniaDtoACompania(companiaDto);
		return companiaRepository.save(compania);
	}

	private Compania convertirCompaniaDtoACompania(CompaniaDto companiaDto) {
		Compania compania = new Compania();
		compania.setNombreCompania(companiaDto.getNombreCompania());
		compania.setClaseVia(companiaDto.getClaseVia());
		compania.setNombreVia(companiaDto.getNombreVia());
		compania.setNumeroVia(companiaDto.getNumeroVia());
		compania.setCodPostal(companiaDto.getCodPostal());
		compania.setTelefonoContratacion(companiaDto.getTelefonoContratacion());
		compania.setTelefonoSiniestros(companiaDto.getTelefonoSiniestros());
		compania.setNotas(companiaDto.getNotas());
		return compania;
	}

	@Override
	public void deleteCompania(@PathVariable("nombreCompania") String nombreCompania) {

		Optional<Compania> compania;

		compania = companiaRepository.findById(nombreCompania);

		if (compania.isPresent()) {

			companiaRepository.delete(compania.get());
		}

	}

	@Override
	public List<Compania> bucarContengaNumero(@PathVariable String cadena) {
		return companiaRepository.findByCodPostalEndingWith(cadena);

	}
}
