package universales.curso.apiGet.Service;

import java.util.List;

public interface ModeloRepository {

	List<Datos> resultado(String name);

	List<DatosPropuestos> resultadoPropuesto(String name);

	List<Datos> resultadoItunes(String name) throws Exception;

	List<DatosPropuestos> resultadoItunesPropuesto(String name) throws Exception;

	List<Datos> practicaUno(String name) throws Exception;

	List<DatosPropuestos> practicaPropuesta(String name) throws Exception;

}
