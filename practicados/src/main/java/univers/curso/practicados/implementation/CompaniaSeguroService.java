package univers.curso.practicados.implementation;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import univers.curso.practicados.entity.CompaniaSeguro;
import univers.curso.practicados.repository.CompaniaSeguroRepository;
import univers.curso.practicados.ws.CompaniaSeguroServiceInterface;

@Component
public class CompaniaSeguroService implements CompaniaSeguroServiceInterface {

	@Autowired
	CompaniaSeguroRepository companiaSeguroRepository;

	@Override
	public List<CompaniaSeguro> buscar() {
		return companiaSeguroRepository.findAll();
	}

}
