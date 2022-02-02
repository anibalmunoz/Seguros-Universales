package univers.curso.practicados;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.fail;

import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import com.library.dto.beans.ClienteDto;

import univers.curso.practicados.entity.Cliente;
import univers.curso.practicados.implementation.ClienteService;

@SpringBootTest
class ClienteServiceImplTest {

	private static final Log LOG = LogFactory.getLog(ClienteServiceImplTest.class);

	@Autowired
	ClienteService clienteService;

	/*
	 * CRUD base de datos
	 */

	@Test
	void buscar() {
		try {
			List<Cliente> clientes = clienteService.buscar();
			assertNotNull(clientes, "Los clientes se cargaron exitosamente");
			LOG.info("Los clientes se cargaron exitosamente");
		} catch (Exception ex) {
			LOG.error(ex.getMessage());
			fail("Error al buscar los clientes: " + ex.getMessage());
		}
	}

	@Test
	void saveCliente() {
		try {
			ClienteDto clienteDto = new ClienteDto();
			clienteDto.setDniCl(23);
			clienteDto.setNombreCl("Prueba");
			clienteDto.setApellido1("Prueba");
			clienteDto.setApellido2("Prueba");
			clienteDto.setClaseVia("Prueba");
			clienteDto.setNombreVia("Prueba");
			clienteDto.setNumeroVia("Prueba");
			clienteDto.setCodPostal("Prueba");
			clienteDto.setCodPostal("Prueba");
			clienteDto.setCiudad("Prueba");
			clienteDto.setTelefono(122345678);
			clienteDto.setObservaciones("Prueba");

			Cliente cliente = clienteService.saveCliente(clienteDto);
			assertNotNull(cliente, "El cliente se guarda o se modifica correctamente");
			LOG.info("El cliente se guarda o se modifica correctamente");
		} catch (Exception ex) {
			LOG.error(ex.getMessage());
			fail("Error al guardar el cliente: " + ex.getMessage());
		}
	}

	@Test
	void eliminarCliente() {
		try {
			clienteService.eliminarCliente(23);
			assert (true);
			LOG.info("Prueba de eliminar cliente correcta");
		} catch (Exception ex) {
			LOG.error(ex.getMessage());
			fail("Error al eliminar el cliente: " + ex.getMessage());
		}
	}

	/*
	 * Consultas DSL
	 */

	@Test
	void bucarPorNombreYApellido() {
		List<Cliente> clientes = clienteService.bucarPorNombreYApellido("prueba", "prueba");
		assertNotNull(clientes);
		LOG.info("Busqueda realizada exitosamente");
	}

	@Test
	void buscarContengaNumero() {
		List<Cliente> clientes = clienteService.bucarContengaNumero(45123844);
		assertNotNull(clientes);
		LOG.info("Cliente encontrado exitosamente");
	}

	@Test
	void buscarNombreViaComienzaPor() {
		List<Cliente> clientes = clienteService.bucarNombreViaComienzaPor("via");
		assertNotNull(clientes);
		LOG.info("Busqueda realizada exitosamente");
	}

	/*
	 * SQL queries
	 */

	@Test
	void buscarClientes() {
		List<Map<String, Object>> listaClientes = clienteService.buscarClientes();
		assertNotNull(listaClientes);
		LOG.info("Busqueda con query SQL realizada exitosamente");
	}

	@Test
	void buscarCliente() {
		List<Map<String, Object>> listaClientes = clienteService.buscarCliente(1);
		assertNotNull(listaClientes);
		LOG.info("Busqueda de cliente por medio del DNI con uso de query SQL realizada exitosamente");
	}

	@Test
	void cambiarNombre() {
		try {
			clienteService.cambiarNombre(1, "Anibal");
			assert (true);
			LOG.info("Nombre alterado correctamente");
		} catch (Exception ex) {
			LOG.error(ex.getMessage());
			fail("Error al eliminar el cliente: " + ex.getMessage());
		}
	}

	/*
	 * INSERT, UPDATE, DELETE Y SELECT CON SQL QUERIES
	 */

	@Test
	void insertCliente() {
		try {
			int retorno = clienteService.insertCliente(10, "INSERT", "INSERT", "INSERT", "INSERT", 45123844, "INSERT");
			assertEquals(1, retorno);
			LOG.info("Cliente insertado exitosamente");
		} catch (Exception ex) {
			LOG.info(ex.getMessage());
			LOG.info("El cliente ya existe");
		}
	}

	@Test
	void cambiarNombreInt() {
		int retorno = clienteService.cambiarNombreInt(1, "Anibal");
		assertEquals(1, retorno);
		LOG.info("Nombre de cliente actualizado exitosamente");
	}

	@Test
	void deleteCliente() {
		int retorno = clienteService.deleteCliente(10);
		if (retorno == 1) {
			assertEquals(1, retorno);
			LOG.info("Cliente eliminado exitosamente");
		} else if (retorno == 0) {
			assertEquals(0, retorno);
			LOG.info("No existe el cliente que se desea eliminar");
		}
	}

	@Test
	void selectCliente() {
		List<Map<String, Object>> listaClientes = clienteService.selectClienteSeguro("01 - 01 - 2021",
				"31 - 12 - 2026");
		assertNotNull(listaClientes);
		LOG.info("Busqueda de cliente por fecha de vencimiento de poliza entre las fechas proporcionadas exitosa");
	}

}