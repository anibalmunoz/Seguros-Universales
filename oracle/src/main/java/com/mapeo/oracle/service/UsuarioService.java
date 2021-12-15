package com.mapeo.oracle.service;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.mapeo.oracle.entity.Usuario;
import com.mapeo.oracle.repository.UsuarioRepository;

@RestController
@RequestMapping("/usuario")
@CrossOrigin
public class UsuarioService {

	@Autowired
	UsuarioRepository usuarioRepository;

	@GetMapping(path = "/buscar")
	public List<Usuario> buscar() {
		return usuarioRepository.findAll();
	}

	@PostMapping(path = "/guardar")
	public Usuario guardar(@RequestBody Usuario usuario) {
		return usuarioRepository.save(usuario);
	}
	
	@DeleteMapping(path="/eliminar/{id}")
	public void eliminar(@PathVariable int id ) {
		Optional<Usuario> usuario=usuarioRepository.findById(id);
		if(usuario.isPresent()) {
			usuarioRepository.delete(usuario.get());
		}
	}
	

}
