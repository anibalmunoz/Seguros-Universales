package univers.curso.practicados;

import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.fail;

import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import com.library.dto.beans.CompaniaDto;

import univers.curso.practicados.entity.Compania;
import univers.curso.practicados.implementation.CompaniaService;

@SpringBootTest
class CompaniaServiceImplTest {

	private static final Log LOG = LogFactory.getLog(CompaniaServiceImplTest.class);

	@Autowired
	CompaniaService companiaService;

	@Test
	void buscar() {
		List<Compania> companias = companiaService.buscar();
		assertNotNull(companias, "Busqueda realizada exitosamente");
		LOG.info("Busqueda realizada exitosamente");
	}

	@Test
	void guardar() {
		try {
			CompaniaDto companiaDto = new CompaniaDto();
			companiaDto.setNombreCompania("TEST");
			companiaDto.setClaseVia("TEST");
			companiaDto.setNombreVia("TEST");
			companiaDto.setNumeroVia("TEST");
			companiaDto.setCodPostal("TEST");
			companiaDto.setTelefonoContratacion("TEST");
			companiaDto.setTelefonoSiniestros("TEST");
			companiaDto.setNotas("TEST");

			Compania compania = companiaService.guardar(companiaDto);
			assertNotNull(compania, "La compania se guarda o se modifica correctamente");
			LOG.info("La compania se guarda o se modifica correctamente");
		} catch (Exception ex) {
			LOG.error(ex.getMessage());
			fail("Error al guardar la compania: " + ex.getMessage());
		}
	}

	@Test
	void eliminar() {
		try {
			companiaService.deleteCompania("TEST");
			assert (true);
			LOG.info("Test de eliminar compania correcta");
		} catch (Exception ex) {
			LOG.error(ex.getMessage());
			fail("Error al eliminar la compania: " + ex.getMessage());
		}
	}
	
	/*
	 * Consulta DSL
	 */
	
	@Test
	void buscarCodigoPostalTermineCon() {
		List<Compania> companias = companiaService.bucarContengaNumero("12345");
		assertNotNull(companias);
		LOG.info("Busqueda realizada exitosamente");
	}

}
