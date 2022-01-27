package univers.curso.practicados;

import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.fail;

import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import com.library.dto.beans.PeritoDto;

import univers.curso.practicados.entity.Perito;
import univers.curso.practicados.implementation.PeritoService;

@SpringBootTest
class PeritoServiceImplTest {

	private static final Log LOG = LogFactory.getLog(PeritoServiceImplTest.class);

	@Autowired
	PeritoService peritoService;

	@Test
	void buscar() {
		List<Perito> peritos = peritoService.buscar();
		assertNotNull(peritos, "Busqueda realizada exitosamente");
		LOG.info("Busqueda realizada exitosamente");
	}

	@Test
	void guardar() {
		try {
			PeritoDto peritoDto = new PeritoDto();
			peritoDto.setDniPerito(1);
			peritoDto.setNombrePerito("TEST");
			peritoDto.setApellidoPerito1("TEST");
			peritoDto.setApellidoPerito2("TEST");
			peritoDto.setTelefonoContacto(12345678);
			peritoDto.setTelefonoOficina(12345678);
			peritoDto.setClaseVia("TEST");
			peritoDto.setNombreVia("TEST");
			peritoDto.setNumeroVia("TEST");
			peritoDto.setCodPostal("TEST");
			peritoDto.setCiudad("TEST");

			Perito perito = peritoService.savePerito(peritoDto);
			assertNotNull(perito, "El perito se guarda o se modifica correctamente");
			LOG.info("El perito se guarda o se modifica correctamente");
		} catch (Exception ex) {
			LOG.error(ex.getMessage());
			fail("Error al guardar el perito: " + ex.getMessage());
		}
	}

	@Test
	void eliminar() {
		try {
			peritoService.deletePerito(1);
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
	void buscarApellido2Vacio() {
		List<Perito> peritos = peritoService.apellido2Vacio();
		assertNotNull(peritos, "Busqueda realizada correctamente");
		LOG.info("Busqueda realizada exitosamente");
	}

	@Test
	void buscarApellido2Utilizado() {
		List<Perito> peritos = peritoService.apellido2NoVacio();
		assertNotNull(peritos, "Busqueda realizada correctamente");
		LOG.info("Busqueda realizada exitosamente");
	}
}
