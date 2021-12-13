package universales.apiGetDos.Service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/rest")
public class Controller {
	@Autowired
	ModeloRepository modeloRepository;

/*	@RequestMapping("/find")
	public List<Modelo> getAllModelos() {
		List<Modelo> modelos = modeloRepository.findAll();
		return modelos;
	}*/
}
