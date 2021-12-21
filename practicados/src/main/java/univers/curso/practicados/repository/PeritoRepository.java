package univers.curso.practicados.repository;

import java.io.Serializable;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import univers.curso.practicados.entity.Perito;

@Repository("peritoRepository")
public interface PeritoRepository extends JpaRepository<Perito, Serializable> {

	public List<Perito> findByApellidoPerito2IsNull();
	
	public List<Perito> findByApellidoPerito2NotNull();
	
}
