package univers.curso.practicados.implementation;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;

import com.library.dto.beans.PeritoDto;

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
	public Perito savePerito(@RequestBody PeritoDto peritoDto) {
		Perito perito = convertirPeritoDtoAPerito(peritoDto);
		return peritoRepository.save(perito);
	}

	private Perito convertirPeritoDtoAPerito(PeritoDto peritoDto) {
		Perito perito = new Perito();
		perito.setDniPerito(peritoDto.getDniPerito());
		perito.setNombrePerito(peritoDto.getNombrePerito());
		perito.setApellidoPerito1(peritoDto.getApellidoPerito1());
		perito.setApellidoPerito2(peritoDto.getApellidoPerito2());
		perito.setTelefonoContacto(peritoDto.getTelefonoContacto());
		perito.setTelefonoOficina(peritoDto.getTelefonoOficina());
		perito.setClaseVia(peritoDto.getClaseVia());
		perito.setNombreVia(peritoDto.getNombreVia());
		perito.setNumeroVia(peritoDto.getNumeroVia());
		perito.setCodPostal(peritoDto.getCodPostal());
		perito.setCiudad(peritoDto.getCiudad());
		return perito;
	}

	@Override
	public void deletePerito(@PathVariable("dniPerito") Integer dniPerito) {
		Optional<Perito> perito;
		perito = peritoRepository.findById(dniPerito);
		if (perito.isPresent()) {
			peritoRepository.delete(perito.get());
		}
	}

	@Override
	public List<Perito> apellido2Vacio() {
		return peritoRepository.findByApellidoPerito2IsNull();
	}

	@Override
	public List<Perito> apellido2NoVacio() {
		return peritoRepository.findByApellidoPerito2NotNull();
	}

}
