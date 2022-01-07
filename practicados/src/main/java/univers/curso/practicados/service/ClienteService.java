package univers.curso.practicados.service;

import java.util.LinkedList;
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

import univers.curso.practicados.dto.ClienteDto;
import univers.curso.practicados.entity.Cliente;
import univers.curso.practicados.entity.Seguro;
import univers.curso.practicados.repository.ClienteRepository;
import univers.curso.practicados.repository.SeguroRepository;

@RestController
@RequestMapping("/cliente")
@CrossOrigin
public class ClienteService {

	@Autowired
	ClienteRepository clienteRepository;

	@Autowired
	SeguroRepository seguroRepository;

	@GetMapping(path = "/buscar")
	public List<Cliente> buscar() {
		return clienteRepository.findAll();
	}

	@PostMapping(path = "/guardar")
	public Cliente saveCliente(@RequestBody ClienteDto clienteDto) {
		Cliente cliente = convertirClienteDtoACliente(clienteDto);	
		List<Seguro> segurosClienteList = cliente.getSegurosList();
		cliente.setSegurosList(null);
		cliente = clienteRepository.save(cliente);
		cliente.setSegurosList(new LinkedList<>());
		if (segurosClienteList != null) {
			for (Seguro seguro : segurosClienteList) {
				seguro.setDniCl(cliente.getDniCl());
				seguroRepository.save(seguro);
				cliente.getSegurosList().add(seguro);
			}

		}
		return cliente;
	}

	private Cliente convertirClienteDtoACliente(ClienteDto clienteDto) {
		Cliente cliente = new Cliente();
		cliente.setDniCl(clienteDto.getDniCl());		
		cliente.setNombreCl(clienteDto.getNombreCl());
		cliente.setApellido1(clienteDto.getApellido1());
		cliente.setApellido2(clienteDto.getApellido2());
		cliente.setClaseVia(clienteDto.getClaseVia());
		cliente.setNombreVia(clienteDto.getNombreCl());
		cliente.setNumeroVia(clienteDto.getNumeroVia());
		cliente.setCodPostal(clienteDto.getCodPostal());
		cliente.setCiudad(clienteDto.getCiudad());
		cliente.setTelefono(clienteDto.getTelefono());
		cliente.setObservaciones(clienteDto.getObservaciones());
		cliente.setSegurosList(clienteDto.getSegurosList());
		return cliente;
	}

	@DeleteMapping(path = "/eliminar/{dniCl}")
	public void eliminarCliente(@PathVariable("dniCl") Integer dniCl) {

		Optional<Cliente> cliente;
		cliente = clienteRepository.findById(dniCl);

		if (cliente.isPresent()) {
			Cliente borrar = cliente.get();

			for (Seguro seguro : borrar.getSegurosList()) {
				seguroRepository.delete(seguro);
			}

			clienteRepository.delete(cliente.get());
		}

	}

	/* Consultas DSL */

	@GetMapping(path = "/bucar/por/{nombreCl}/{apellido1}")
	public List<Cliente> bucarPorNombreYApellido(@PathVariable("nombreCl") String nombreCl,
			@PathVariable("apellido1") String apellido1) {
		return clienteRepository.findByNombreClAndApellido1(nombreCl, apellido1);

	}

	@GetMapping(path = "/bucar/telefono/igual/{telefono}")
	public List<Cliente> bucarContengaNumero(@PathVariable Integer telefono) {
		return clienteRepository.findByTelefonoLike(telefono);

	}

	@GetMapping(path = "/bucar/nombrevia/comienza/{cadena}")
	public List<Cliente> bucarContengaNumero(@PathVariable String cadena) {
		return clienteRepository.findByNombreViaStartingWith(cadena);

	}

}
