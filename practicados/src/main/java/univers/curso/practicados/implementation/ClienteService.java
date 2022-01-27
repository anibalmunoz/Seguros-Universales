package univers.curso.practicados.implementation;

import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.library.dto.beans.ClienteDto;

import univers.curso.practicados.entity.Cliente;
import univers.curso.practicados.entity.Seguro;
import univers.curso.practicados.repository.ClienteRepository;
import univers.curso.practicados.repository.SeguroRepository;
import univers.curso.practicados.service.CatalogosService;
import univers.curso.practicados.ws.ClienteServiceInterface;

@Component
public class ClienteService implements ClienteServiceInterface {

	@Autowired
	ClienteRepository clienteRepository;

	@Autowired
	SeguroRepository seguroRepository;

	@Autowired
	CatalogosService catalogosService;

	@Override
	public List<Cliente> buscar() {
		return clienteRepository.findAll();
	}

	@Override
	public Cliente saveCliente(ClienteDto clienteDto) {
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
		return cliente;
	}

	@Override
	public void eliminarCliente(Integer dniCl) {

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

	@Override
	public List<Cliente> bucarPorNombreYApellido(String nombreCl, String apellido1) {
		return clienteRepository.findByNombreClAndApellido1(nombreCl, apellido1);

	}

	@Override
	public List<Cliente> bucarContengaNumero(Integer telefono) {
		return clienteRepository.findByTelefonoLike(telefono);

	}

	@Override
	public List<Cliente> bucarNombreViaComienzaPor(String cadena) {
		return clienteRepository.findByNombreViaStartingWith(cadena);

	}

	/*
	 * Queries SQL
	 */

	@Override
	public List<Map<String, Object>> buscarClientes() {
		return catalogosService.buscarClientes();
	}

	@Override
	public List<Map<String, Object>> buscarCliente(Integer dniCl) {
		return catalogosService.buscarCliente(dniCl);
	}

	@Override
	public void cambiarNombre(Integer dniCl, String nombreCl) {
		catalogosService.cambiarNombre(dniCl, nombreCl);
	}

	/*
	 * INSERT, UPDATE, DELETE Y SELECT CON SQL QUERIES 
	 */
	

	@Override
	public int insertCliente(Integer dniCl, String nombreCl, String apellido1, String codPostal, String ciudad,
			Integer telefono, String observaciones) {
		return catalogosService.insertCliente(dniCl, nombreCl, apellido1, codPostal, ciudad, telefono, observaciones);
	}

	@Override
	public int cambiarNombreInt(Integer dniCl, String nombreCl) {
		return catalogosService.cambiarNombreInt(dniCl, nombreCl);
	}
	
	@Override
	public int deleteCliente(Integer dniCl) {
		return catalogosService.deleteCliente(dniCl);
	}

	@Override
	public List<Map<String, Object>> selectClienteSeguro(String fechaInicio, String fechaVencimiento) {
		return catalogosService.selectClienteSeguro(fechaInicio, fechaVencimiento);
	}

}
