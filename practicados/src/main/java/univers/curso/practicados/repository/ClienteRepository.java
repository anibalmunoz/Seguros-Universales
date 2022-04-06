package univers.curso.practicados.repository;

import java.io.Serializable;
import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import univers.curso.practicados.dto.GroupByDto;
import univers.curso.practicados.entity.Cliente;

@Repository("clienteRepository")
public interface ClienteRepository extends JpaRepository<Cliente, Serializable> {

	public List<Cliente> findByNombreClAndApellido1(String nombreCl, String apellido1);

	public List<Cliente> findByTelefonoLike(Integer telefono);

	public List<Cliente> findByNombreViaStartingWith(String cadena);
	
	public List<Cliente> findByDniClEquals(Integer dniCl);
	

	/*
	 * JPQL y QUERIES NATIVOS
	 */

 	@Query(value = "SELECT * FROM CLIENTE WHERE CIUDAD LIKE :ciudad ORDER BY DNI_CL ", countQuery = "SELECT COUNT(1) FROM CLIENTE", nativeQuery = true)
	public Page<Cliente> buscarGuatemala(Pageable pageable, @Param("ciudad") String ciudad);

	@Query(value = "select apellido_1, count(*) , ciudad from cliente group by apellido_1 , ciudad", nativeQuery = true)
	public List<Object[]> agregacion();

	public List<Cliente> buscarTodos();

	@Query(value = "select * FROM CLIENTE LEFT JOIN seguro ON SEGURO.DNI_CL = CLIENTE.DNI_CL ORDER BY cliente.dni_cl DESC", nativeQuery = true)
	public List<Cliente> join();

	@Query("SELECT new univers.curso.practicados.dto.GroupByDto (cli.apellido1, count(cli.apellido1), cli.ciudad) FROM Cliente cli "
			+ "GROUP BY  cli.apellido1, cli.ciudad")
	public List<GroupByDto> groupBy();

}