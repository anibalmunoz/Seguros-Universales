package univers.curso.practicados.implementation;

import java.sql.Date;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.stereotype.Component;

import univers.curso.practicados.dto.SeguroDto;

import univers.curso.practicados.entity.Seguro;
import univers.curso.practicados.repository.SeguroRepository;
import univers.curso.practicados.service.CatalogosService;
import univers.curso.practicados.ws.SeguroServiceInterface;

@Component
public class SeguroService implements SeguroServiceInterface {

	@Autowired
	SeguroRepository seguroRepository;
	
	@Autowired
	CatalogosService catalogosService;
	
	@Override
	public List<Seguro> buscar() {
		return seguroRepository.findAll();
	}

	@Override
	public Seguro guardar(SeguroDto seguroDto) {
		Seguro seguro = convertirSeguroDtoASeguro(seguroDto);
		return seguroRepository.save(seguro);
	}

	private Seguro convertirSeguroDtoASeguro(SeguroDto seguroDto) {
		ModelMapper modelMapper = new ModelMapper();
		return modelMapper.map(seguroDto, Seguro.class);
	}

	@Override
	public void deleteSeguro(Integer numeroPoliza) {
		Optional<Seguro> seguro;
		seguro = seguroRepository.findById(numeroPoliza);
		if (seguro.isPresent()) {
			seguroRepository.delete(seguro.get());
		}
	}


	@Override
	public List<Map<String, Object>> buscarSegurosCliente(Integer dniCl) {
		return catalogosService.buscarPolizasCliente(dniCl);
	}

	
	/*
	 * Consulta DSL
	 */
	
	@Override
	public List<Seguro> bucarFechaDespuesDe(Date fechaInicio) {
		return seguroRepository.findByFechaInicioAfter(fechaInicio);
	}


	// localhost:8080/seguro/buscar/fecha/despuesde/2010-10-09
	
	
	
	/*Implementacioón Servico A. Jeronimo */
	@Override
	public Page<Seguro> segurosForPage(Integer pagina, Integer cantidad) {

		Pageable paginador = PageRequest.of(pagina,cantidad,Sort.by(Direction.DESC,"numeroPoliza"));		
		return seguroRepository.findAll(paginador);
	}

	@Override
	public Page<Seguro> bucarFechaDespuesDePaginado(Date fechaInicio, Integer pagina, Integer cantidad) {

		Pageable paginador = PageRequest.of(pagina, cantidad);
		return seguroRepository.findByFechaInicioAfter(paginador, fechaInicio);
		
	}
	
}
