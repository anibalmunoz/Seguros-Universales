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

import univers.curso.practicados.dto.SiniestroDto;

import univers.curso.practicados.entity.Siniestro;
import univers.curso.practicados.implementation.SiniestroService;

@SpringBootTest
class SiniestroServiceImplTest {
	private static final Log LOG = LogFactory.getLog(SiniestroServiceImplTest.class);

	@Autowired
	SiniestroService siniestroService;

	@Test
	void buscar() {
		List<Siniestro> siniestros = siniestroService.buscar();
		assertNotNull(siniestros, "La busqueda fue realizada correctamente");
		LOG.info("La busqueda fue realizada correctamente");
	}

	@Test
	void guardar() {
		SiniestroDto siniestroDto = new SiniestroDto();
		siniestroDto.setIdSiniestro(1);
		siniestroDto.setFechaSiniestro(null);
		siniestroDto.setCausas("TEST");
		siniestroDto.setAceptado("TEST");
		siniestroDto.setIndemnizacion("TEST");
		siniestroDto.setNumeroPoliza(2);

		ResponseEntity<Siniestro> siniestro = siniestroService.guardar(siniestroDto);
		assertNotNull(siniestro, "Siniestro agregado o modificado exitosamente");
		LOG.info("Siniestro agreagdo o modificado exitosamente");
	}
	
	@Test
	void eliminar() {
		try {
			 siniestroService.deleteSiniestro(1);;
			assert (true);
			LOG.info("Prueba de eliminar cliente correcta");
		} catch (Exception ex) {
			LOG.error(ex.getMessage());
			fail("Error al eliminar el cliente: " + ex.getMessage());
		}
	}
	
	@Test
	void buscarMayorque() {
		List<Siniestro> siniestros = siniestroService.bucarMayorQue(10);
		assertNotNull(siniestros);
		LOG.info("La consulta de busqueda mayor que se realizó correctamente");
	}
	
	@Test
	void buscarMenorque() {
		List<Siniestro> siniestros = siniestroService.bucarMenorQue(10);
		assertNotNull(siniestros);
		LOG.info("La consulta de busqueda menor que se realizó correctamente");
	}

}
