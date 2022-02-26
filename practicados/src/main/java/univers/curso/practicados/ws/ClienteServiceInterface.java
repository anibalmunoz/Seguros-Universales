package univers.curso.practicados.ws;

import java.util.List;
import java.util.Map;

import org.springframework.data.domain.Page;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import univers.curso.practicados.dto.ClienteDto;
import univers.curso.practicados.dto.GroupByDto;
import univers.curso.practicados.entity.Cliente;

@RestController
@RequestMapping("/cliente")
@CrossOrigin
public interface ClienteServiceInterface {

	@GetMapping(path = "/buscar")
	public List<Cliente> buscar();

	@PostMapping(path = "/guardar")
	public ResponseEntity<Cliente> saveCliente(@RequestBody ClienteDto clienteDto);

	@DeleteMapping(path = "/eliminar/{dniCl}")
	public void eliminarCliente(@PathVariable("dniCl") Integer dniCl);

	/*
	 * Consultas DSL
	 */

	@GetMapping(path = "/buscar/por/{nombreCl}/{apellido1}")
	public List<Cliente> bucarPorNombreYApellido(@PathVariable("nombreCl") String nombreCl,
			@PathVariable("apellido1") String apellido1);

	@GetMapping(path = "/buscar/telefono/igual/{telefono}")
	public List<Cliente> bucarContengaNumero(@PathVariable Integer telefono);

	@GetMapping(path = "/buscar/nombrevia/comienza/{cadena}")
	public List<Cliente> bucarNombreViaComienzaPor(@PathVariable String cadena);

	/*
	 * Scripts de bases de datos
	 */

	@GetMapping(path = "/buscar/clientes")
	public List<Map<String, Object>> buscarClientes();

	@GetMapping(path = "/buscar/{dniCl}")
	public List<Map<String, Object>> buscarCliente(@PathVariable Integer dniCl);

	@GetMapping(path = "/cambiar/nombre/{dniCl}/{nombreCl}")
	public void cambiarNombre(@PathVariable Integer dniCl, @PathVariable String nombreCl);

	/*
	 * Insert
	 */
	@GetMapping(path = "/insert/{dniCl}/{nombreCl}/{apellido1}/{codPostal}/{ciudad}/{telefono}/{observaciones}")
	public int insertCliente(@PathVariable Integer dniCl, @PathVariable String nombreCl, @PathVariable String apellido1,
			@PathVariable String codPostal, @PathVariable String ciudad, @PathVariable Integer telefono,
			@PathVariable String observaciones);

	/*
	 * Update
	 */
	@GetMapping(path = "/update/nombre/{dniCl}/{nombreCl}")
	public int cambiarNombreInt(@PathVariable Integer dniCl, @PathVariable String nombreCl);

	/*
	 * Delete
	 */
	@GetMapping(path = "/delete/{dniCl}")
	public int deleteCliente(@PathVariable Integer dniCl);

	/*
	 * Select
	 */
	@GetMapping(path = "/select/poliza/{fechaInicio}/{fechaVencimiento}")
	public List<Map<String, Object>> selectClienteSeguro(@PathVariable String fechaInicio,
			@PathVariable String fechaVencimiento);

	/*
	 * JPQL
	 */

	@GetMapping(path = "/buscar/{ciudad}/{pagina}/{cantidad}")
	public Page<Cliente> buscarGuatemala(@PathVariable("ciudad") String ciudad, @PathVariable("pagina") int pagina,
			@PathVariable("cantidad") int cantidad);

	@GetMapping(path = "/buscar/todos")
	public List<Cliente> buscarTodos();

	@GetMapping(path = "/groupby/ciudad")
	public List<Map<String, Object>> groupByCatalogo();

	@GetMapping(path = "/join")
	public List<Cliente> join();

	@GetMapping(path = "/funcion")
	public List<GroupByDto> groupBy();
}
