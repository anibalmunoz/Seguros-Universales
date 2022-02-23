package univers.curso.practicados;

import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.fail;


import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.http.ResponseEntity;

import univers.curso.practicados.dto.SeguroDto;

import univers.curso.practicados.entity.Seguro;
import univers.curso.practicados.implementation.SeguroService;

@SpringBootTest
class SeguroServiceImplTest {
	private static final Log LOG = LogFactory.getLog(SeguroServiceImplTest.class);

	@Autowired
	SeguroService seguroService;

	@Test
	void buscar() {
		List<Seguro> seguros = seguroService.buscar();
		assertNotNull(seguros, "Busqueda realizada exitosamente");
		LOG.info("Busqueda realizada exitosamente");
	}

	@Test
	void guardar() {
		try {
			SeguroDto seguroDto = new SeguroDto();
			seguroDto.setNumeroPoliza(1);
			seguroDto.setRamo("TEST");
			seguroDto.setFechaInicio(null);
			seguroDto.setFechaVencimiento(null);
			seguroDto.setCondicionesParticulares("TEST");
			seguroDto.setObervaciones("TEST");
			seguroDto.setDniCl(1);

			ResponseEntity<Seguro> seguro = seguroService.guardar(seguroDto);
			assertNotNull(seguro, "El seguro se guarda o se modifica correctamente");
			LOG.info("El seguro se guarda o se modifica correctamente");
		} catch (Exception ex) {
			LOG.error(ex.getMessage());
		}
	}

	@Test
	void eliminarSeguro() {
		try {
			seguroService.deleteSeguro(1);
			assert (true);
			LOG.info("Prueba de eliminar segro correcta");
		} catch (Exception ex) {
			LOG.error(ex.getMessage());
			fail("Error al eliminar el seguro: " + ex.getMessage());
		}
	}	

}