package universales.curso.apiGet.Service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

@RestController
@CrossOrigin
public class Controller {

	public static final Logger logger = LoggerFactory.getLogger(Controller.class);

	@Autowired
	@Qualifier("modeloRepository")
	private ModeloRepository modeloRepository;

	@GetMapping(path = "/rest/find/video/{name}", produces = { MediaType.APPLICATION_JSON_VALUE,
			MediaType.APPLICATION_XML_VALUE })
	public List<DatosPropuestos> practicaPropuestos(@PathVariable("name") String name) throws Exception {

		return modeloRepository.practicaPropuesta(name);
	}

	@GetMapping(path = "/rest/find/{name}", produces = { MediaType.APPLICATION_JSON_VALUE,
			MediaType.APPLICATION_XML_VALUE })
	public List<Datos> practicaUno(@PathVariable("name") String name) throws Exception {

		return modeloRepository.practicaUno(name);
	}
}
