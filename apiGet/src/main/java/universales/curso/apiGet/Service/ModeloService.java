package universales.curso.apiGet.Service;

import java.io.IOException;
import java.util.Arrays;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.ParameterizedTypeReference;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpRequest;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.http.client.ClientHttpRequestExecution;
import org.springframework.http.client.ClientHttpRequestInterceptor;
import org.springframework.http.client.ClientHttpResponse;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import universales.curso.apiGet.Modelo;

@Service("modeloRepository")
public class ModeloService implements ModeloRepository{

	public static final Logger logger = LoggerFactory.getLogger(ModeloService.class);
	

	@Autowired
	private RestTemplate restTemplate;
	
	@Override
	public ResponseEntity<List<Modelo>> resultado() {

		logger.info("Inicia Busqueda Comentarios Con Exchange");

		HttpHeaders headers = new HttpHeaders();

		headers.setContentType(MediaType.APPLICATION_JSON);
		headers.setAccept(Arrays.asList(MediaType.APPLICATION_JSON));

		HttpEntity<Modelo> entity = new HttpEntity<>(headers);

		ResponseEntity<List<Modelo>> response = restTemplate.exchange(
				"https://jsonplaceholder.typicode.com/comments", HttpMethod.GET, entity,
				new ParameterizedTypeReference<List<Modelo>>() {
				});

		logger.info("Response: {}", response.getBody());

		return new ResponseEntity<>(response.getBody(), HttpStatus.OK);
	}
	
	
	
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public List<Modelo> buscarComentariosConForEntity() {

		logger.info("Inicia Busqueda Comentarios Con For Entity");

		restTemplate.getInterceptors().add(new ClientHttpRequestInterceptor() {
			@Override
			public ClientHttpResponse intercept(HttpRequest request, byte[] body, ClientHttpRequestExecution execution)
					throws IOException {
				request.getHeaders().setContentType(MediaType.APPLICATION_JSON);
				request.getHeaders().setAccept(Arrays.asList(MediaType.APPLICATION_JSON));
				return execution.execute(request, body);
			}
		});

		ResponseEntity<List> response = restTemplate.getForEntity("https://jsonplaceholder.typicode.com/comments",
				List.class);

		logger.info("Response: {}", response.getBody());

		List<Modelo> object = response.getBody();

		return object;
	}
	
	
}
