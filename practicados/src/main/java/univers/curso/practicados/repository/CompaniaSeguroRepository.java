package univers.curso.practicados.repository;

import java.io.Serializable;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import univers.curso.practicados.entity.CompaniaSeguro;
@Repository("companiaSeguroRepository")
public interface CompaniaSeguroRepository extends JpaRepository<CompaniaSeguro, Serializable> {

}
