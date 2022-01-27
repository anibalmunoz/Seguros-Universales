package univers.curso.practicados.repository;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import univers.curso.practicados.entity.Seguro;

@Repository ("seguroRepository")
public interface SeguroRepository  extends JpaRepository<Seguro, Serializable>{

	public List<Seguro> findByFechaInicioAfter (Date fechaInicio);
	
}