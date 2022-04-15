package univers.curso.practicados.ws;

import java.util.List;

import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import univers.curso.practicados.entity.Usuario;

@RestController
@RequestMapping("/usuario")
@CrossOrigin
public interface UsuarioServiceInterface {
	
	@GetMapping(path = "/buscar")
	public List<Usuario> buscar();

}
