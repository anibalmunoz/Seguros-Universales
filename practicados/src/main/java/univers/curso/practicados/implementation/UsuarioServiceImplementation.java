package univers.curso.practicados.implementation;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import univers.curso.practicados.entity.Usuario;
import univers.curso.practicados.repository.UsuarioRepository;
import univers.curso.practicados.ws.UsuarioServiceInterface;

public class UsuarioServiceImplementation implements UsuarioServiceInterface {
	
	@Autowired
	UsuarioRepository usuarioRepository;
	
	@Override
	public List<Usuario> buscar() {
		return usuarioRepository.findAll();
	}

}
