package univers.curso.practicados.repository;

import java.io.Serializable;
import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import univers.curso.practicados.entity.Perito;

@Repository("peritoRepository")
public interface PeritoRepository extends JpaRepository<Perito, Serializable> {

	public List<Perito> findByApellidoPerito2IsNull();

	public List<Perito> findByApellidoPerito2NotNull();

	public List<Perito> findByDniPeritoEquals(Integer dniPerito);

	@Query("SELECT p.nombrePerito FROM Perito p")
	public List<Object[]> prueba();

	public Page<Perito> findByNombrePeritoContaining(Pageable pageable, String nombrePerito);

}
