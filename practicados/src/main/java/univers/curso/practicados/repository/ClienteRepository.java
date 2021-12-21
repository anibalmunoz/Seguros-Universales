package univers.curso.practicados.repository;

import java.io.Serializable;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import univers.curso.practicados.entity.Cliente;

@Repository("clienteRepository")
public interface ClienteRepository extends JpaRepository<Cliente, Serializable> {
	
	public List<Cliente> findByNombreClAndApellido1 (String nombreCl, String apellido1);
	
	public List<Cliente> findByTelefonoLike (Integer telefono);
	
	public List<Cliente> findByNombreViaStartingWith(String cadena);

}