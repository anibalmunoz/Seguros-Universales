package univers.curso.practicados.implementation;

import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import javax.persistence.EntityManager;

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


import univers.curso.practicados.dto.ClienteDto;
import univers.curso.practicados.dto.GroupByDto;
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

	@Autowired
	EntityManager entityManager;

	@Override
	public List<Cliente> buscar() {
		return clienteRepository.findAll();
	}
	
	@Override
	public List<Cliente> buscarDni(Integer dniCl) {
		return clienteRepository.findByDniClEquals(dniCl);
	}

	@Override
	public ResponseEntity<Cliente> saveCliente(ClienteDto clienteDto) {
		Cliente cliente = convertirClienteDtoACliente(clienteDto);

		try {
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
			return new ResponseEntity<>(cliente, null, HttpStatus.OK);
		} catch (Exception ex) {
			return new ResponseEntity<>(null, null, HttpStatus.INTERNAL_SERVER_ERROR);
		}

	}

	private Cliente convertirClienteDtoACliente(ClienteDto clienteDto) {
		ModelMapper modelMapper = new ModelMapper();
		return modelMapper.map(clienteDto, Cliente.class);
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

	/*
	 * JPQL
	 */
	@Override
	public Page<Cliente> buscarGuatemala(String ciudad, int pagina, int cantidad) {
		Pageable paginador = PageRequest.of(pagina, cantidad);
		return clienteRepository.buscarGuatemala(paginador, ciudad);
	}

	@Override
	public List<Cliente> buscarTodos() {
		return clienteRepository.buscarTodos();
	}

	@Override
	public List<Map<String, Object>> groupByCatalogo() {
		return catalogosService.groupBy();
	}

	@Override
	public List<Cliente> join() {
		return clienteRepository.join();
	}

	@Override
	public List<GroupByDto> groupBy() {
		return clienteRepository.groupBy();
	}

	
	/*
	 * Paginador de clientes
	 */
	@Override
	public Page<Cliente> buscarPaginado(int pagina, int cantidad) {
		Pageable pageable = PageRequest.of(pagina, cantidad, Sort.by(Direction.ASC, "dniCl"));
		return clienteRepository.findAll(pageable);
	}

	
}
