package univers.curso.practicados;

import static org.junit.jupiter.api.Assertions.assertNotNull;

import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import univers.curso.practicados.entity.CompaniaSeguro;
import univers.curso.practicados.implementation.CompaniaSeguroService;

@SpringBootTest
class CompaniaSeguroServiceImplTest {

	private static final Log LOG = LogFactory.getLog(CompaniaSeguroServiceImplTest.class);

	
	@Autowired
	CompaniaSeguroService companiaSeguroService;
	
	@Test
	void buscar() {
		List<CompaniaSeguro> companiasYSeguros = companiaSeguroService.buscar();
		assertNotNull(companiasYSeguros, "Busqueda realizada exitosamente");
		LOG.info("Busqueda realizada exitosamente");
	}
	
}
