package univers.curso.practicados.service;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import univers.curso.practicados.dto.PeritoDto;
import univers.curso.practicados.entity.Perito;
import univers.curso.practicados.repository.PeritoRepository;

@RestController
@RequestMapping("/perito")
@CrossOrigin
public class PeritoService {

	@Autowired
	PeritoRepository peritoRepository;

	@GetMapping(path = "/buscar")
	public List<Perito> buscar() {
		return peritoRepository.findAll();
	}

	@PostMapping(path = "/guardar")
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

	@DeleteMapping(path = "/eliminar/{dniPerito}")
	public void deletePerito(@PathVariable("dniPerito") Integer dniPerito) {
		Optional<Perito> perito;
		perito = peritoRepository.findById(dniPerito);
		if (perito.isPresent()) {
			peritoRepository.delete(perito.get());
		}
	}

	@GetMapping(path = "/buscar/apellido2/vacio")
	public List<Perito> apellido2Vacio() {
		return peritoRepository.findByApellidoPerito2IsNull();
	}

	@GetMapping(path = "/buscar/apellido2/ocupado")
	public List<Perito> apellido2NoVacio() {
		return peritoRepository.findByApellidoPerito2NotNull();
	}

}
