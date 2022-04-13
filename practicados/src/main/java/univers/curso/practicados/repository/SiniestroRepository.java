package univers.curso.practicados.repository;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import univers.curso.practicados.entity.Siniestro;
@Repository("siniestroRepository")
public interface SiniestroRepository extends JpaRepository<Siniestro, Serializable> {

	public List<Siniestro> findByNumeroPolizaLessThanEqual(Integer numeroPoliza);

	public List<Siniestro> findByNumeroPolizaGreaterThanEqual(Integer numeroPoliza);
	
	public List<Siniestro> findByFechaSiniestroBefore(Date fechaSiniestro);
	
	public List<Siniestro> findByIdSiniestroEquals(Integer idSiniestro);

	
}
