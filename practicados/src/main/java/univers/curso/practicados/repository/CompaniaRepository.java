package univers.curso.practicados.repository;

import java.io.Serializable;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import univers.curso.practicados.entity.Compania;

@Repository("companiaRepository")
public interface CompaniaRepository extends JpaRepository<Compania, Serializable> {

	public List<Compania> findByCodPostalEndingWith(String cadena);


}
