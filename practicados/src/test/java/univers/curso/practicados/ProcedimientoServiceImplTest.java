package univers.curso.practicados;

import static org.junit.jupiter.api.Assertions.assertNotNull;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.http.ResponseEntity;

import univers.curso.practicados.dto.FuncionDto;
import univers.curso.practicados.dto.ProcedimientoDto;
import univers.curso.practicados.dto.SeguroDto;

import univers.curso.practicados.implementation.ProcedimientoServiceImplementation;

@SpringBootTest
class ProcedimientoServiceImplTest {

	private static final Log LOG = LogFactory.getLog(ProcedimientoServiceImplTest.class);

	@Autowired
	ProcedimientoServiceImplementation procedimientoServiceImplementation;

	@Test
	void insertPolizaReturnPost() {

		SeguroDto seguroDto = new SeguroDto();
		seguroDto.setRamo("TEST");
		seguroDto.setFechaInicio(null);
		seguroDto.setFechaVencimiento(null);
		seguroDto.setCondicionesParticulares("TEST");
		seguroDto.setObervaciones("TEST");
		seguroDto.setDniCl(1);

		ResponseEntity<ProcedimientoDto> procedimientoDto = procedimientoServiceImplementation.insertPolizaReturnPost(seguroDto);
		assertNotNull(procedimientoDto, "Insercion creada exitosamente");
		LOG.info("Insercion creada exitosamente");
	}
	
	@Test
	void insertarSeguro() {
		
		SeguroDto seguroDto = new SeguroDto();
		seguroDto.setRamo("TEST");
		seguroDto.setFechaInicio(null);
		seguroDto.setFechaVencimiento(null);
		seguroDto.setCondicionesParticulares("TEST");
		seguroDto.setObervaciones("TEST");
		seguroDto.setDniCl(1);
		
		ResponseEntity<FuncionDto> funcionDto = procedimientoServiceImplementation.insertarSeguro(seguroDto);
		assertNotNull(funcionDto, "Insercion creada exitosamente");
		LOG.info("Insercion creada exitosamente");
		
	}
	
	@Test
	void obtenerNombre() {
		ProcedimientoDto procedimientoDto = procedimientoServiceImplementation.obtenerNombre(1);
		assertNotNull(procedimientoDto, "Nombre obtenido exitosamente");
		LOG.info("Nombre obtenido exitosamente");
	}

}
