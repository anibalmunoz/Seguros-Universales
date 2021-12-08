package universales.curso.apiGet.Service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import universales.curso.apiGet.Modelo;

@RestController
@CrossOrigin
public class Controller {
	
	public static final Logger logger = LoggerFactory.getLogger(Controller.class);
	
	@Autowired
	@Qualifier("modeloRepository")
	private ModeloRepository modeloRepository;
	
	@GetMapping(path = "rest", 
			produces = { MediaType.APPLICATION_JSON_VALUE,
						 MediaType.APPLICATION_XML_VALUE })
	public ResponseEntity<List<Modelo>> resultado() {

		logger.info("Ingresa a metodo buscarComentariosConExchange");
		
		return modeloRepository.resultado();
	}
	
	
	
	/**
	 * Buscar comentarios con for entity.
	 *
	 * @return the response entity
	 */
	@GetMapping(path="/find", 
			produces = { MediaType.APPLICATION_JSON_VALUE,
					 	 MediaType.APPLICATION_XML_VALUE })
	public ResponseEntity<List<Modelo>> buscarComentariosConForEntity() {
		
		logger.info("Ingresa a metodo buscarComentariosConForObject");

		return new ResponseEntity<>(modeloRepository.buscarComentariosConForEntity(), HttpStatus.OK);
	}
	
}
