package universales.curso.apiGet.Service;

import java.util.Arrays;
import java.util.LinkedList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.ParameterizedTypeReference;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;

import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import com.fasterxml.jackson.databind.ObjectMapper;

@Service("modeloRepository")
public class ModeloService implements ModeloRepository {

	public static final Logger logger = LoggerFactory.getLogger(Controller.class);

	@Autowired
	private RestTemplate restTemplate;

	/*
	 * Resultados de TvMaze
	 */

	@Override
	public List<Datos> resultado(String name) {

		HttpHeaders headers = new HttpHeaders();

		headers.setAccept(Arrays.asList(MediaType.APPLICATION_JSON));

		List<Datos> datos = new LinkedList<>();

		HttpEntity<String> entity = new HttpEntity<>(headers);

		ResponseEntity<List<TvMaze>> response = restTemplate.exchange("https://api.tvmaze.com/search/people?q=" + name,
				HttpMethod.GET, entity, new ParameterizedTypeReference<List<TvMaze>>() {
				});

		if (response.hasBody()) {
			for (TvMaze tv : response.getBody()) {
				Datos registro = new Datos();
				registro.setService("API TVMAZE");
				registro.setServiceUrl("https://api.tvmaze.com/search/people?q=" + name);
				registro.setName(tv.getPerson().getName());
				registro.setType("People");
				datos.add(registro);
			}
		}

		return datos;
	}

	@Override
	public List<DatosPropuestos> resultadoPropuesto(String name) {

		HttpHeaders headers = new HttpHeaders();

		headers.setAccept(Arrays.asList(MediaType.APPLICATION_JSON));

		List<DatosPropuestos> datos = new LinkedList<>();

		HttpEntity<String> entity = new HttpEntity<>(headers);

		ResponseEntity<List<TvMazePropuesta>> response = restTemplate.exchange(
				"https://api.tvmaze.com/search/shows?q=" + name, HttpMethod.GET, entity,
				new ParameterizedTypeReference<List<TvMazePropuesta>>() {
				});

		if (response.hasBody()) {
			for (TvMazePropuesta tv : response.getBody()) {
				DatosPropuestos registro = new DatosPropuestos();
				registro.setService("API TVMAZE");
				registro.setServiceUrl("https://api.tvmaze.com/search/shows?q=" + name);
				registro.setName(tv.getShow().getName());
				registro.setType(tv.getShow().getType());
				registro.setLanguage(tv.getShow().getLanguage());
				registro.setVistaPrevia(tv.getShow().getUrl());
				datos.add(registro);
			}
		}

		return datos;
	}

	/*
	 * Resultados de Itunes
	 */

	@Override
	public List<Datos> resultadoItunes(String name) throws Exception {

		HttpHeaders headers = new HttpHeaders();

		headers.setAccept(Arrays.asList(MediaType.APPLICATION_JSON));

		List<Datos> datos = new LinkedList<>();

		HttpEntity<String> entity = new HttpEntity<>(headers);

		ResponseEntity<String> responseEntity = restTemplate.exchange("https://itunes.apple.com/search?term=" + name,
				HttpMethod.GET, entity, new ParameterizedTypeReference<String>() {
				});

		if (responseEntity.hasBody()) {
			ObjectMapper objectMapper = new ObjectMapper();
			Itunes itunes = objectMapper.readValue(responseEntity.getBody(), Itunes.class);

			for (Result resultado : itunes.getResults()) {
				Datos registro = new Datos();
				registro.setService("API Itunes");
				registro.setServiceUrl("https://itunes.apple.com/search?term=" + name);
				registro.setName(resultado.getArtistName());
				registro.setType(resultado.getKind());
				registro.setTrackName(resultado.getTrackName());
				datos.add(registro);
			}

		}
		return datos;
	}
	
	@Override
	public List<DatosPropuestos> resultadoItunesPropuesto(String name) throws Exception{
		
		HttpHeaders headers = new HttpHeaders();

		headers.setAccept(Arrays.asList(MediaType.APPLICATION_JSON));

		List<DatosPropuestos> datos = new LinkedList<>();

		HttpEntity<String> entity = new HttpEntity<>(headers);

		ResponseEntity<String> responseEntity = restTemplate.exchange("https://itunes.apple.com/search?term="+name+"&entity=musicVideo",
				HttpMethod.GET, entity, new ParameterizedTypeReference<String>() {
				});

		if (responseEntity.hasBody()) {
			ObjectMapper objectMapper = new ObjectMapper();
			Itunes itunes = objectMapper.readValue(responseEntity.getBody(), Itunes.class);

			for (Result resultado : itunes.getResults()) {
				DatosPropuestos registro = new DatosPropuestos();
				registro.setService("API Itunes");
				registro.setServiceUrl("https://itunes.apple.com/search?term="+name+"&entity=musicVideo");
				registro.setName(resultado.getArtistName());
				registro.setType(resultado.getKind());
				registro.setVistaPrevia(resultado.getPreviewUrl());
				datos.add(registro);
			}

		}
		return datos;
		
	}
	
	
	public List<Datos>  practicaUno (String name) throws Exception {
		List<Datos> datos=new LinkedList<>();
		
		datos.addAll(resultado(name));
		datos.addAll(resultadoItunes(name));
		
		return datos;
	}
	
	public List<DatosPropuestos>  practicaPropuesta (String name) throws Exception {
		List<DatosPropuestos> datos=new LinkedList<>();
		
		datos.addAll(resultadoPropuesto(name));
		datos.addAll(resultadoItunesPropuesto(name));
		
		return datos;
	}
	
	
}
