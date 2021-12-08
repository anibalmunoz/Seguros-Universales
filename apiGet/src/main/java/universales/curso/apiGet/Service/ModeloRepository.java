package universales.curso.apiGet.Service;
import java.util.List;

import org.springframework.http.ResponseEntity;

import universales.curso.apiGet.Modelo;

public interface ModeloRepository {

	ResponseEntity<List<Modelo>> resultado();

	List<Modelo> buscarComentariosConForEntity();

	//List<Modelo> buscarComentariosConForObject();

}
