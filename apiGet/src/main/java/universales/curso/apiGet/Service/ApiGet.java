package universales.curso.apiGet.Service;

import java.util.Arrays;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.web.client.RestTemplateBuilder;
import org.springframework.context.annotation.Bean;
import org.springframework.http.ResponseEntity;
import org.springframework.http.client.SimpleClientHttpRequestFactory;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;

import universales.curso.apiGet.Modelo;
//@RestController
//@RequestMapping("/rest")
//@CrossOrigin
@SpringBootApplication
public class ApiGet {

	public static void main(String[] args) {
		SpringApplication.run(ApiGet.class, args);
	}

	
	@Bean public RestTemplate restTemplate() {
		SimpleClientHttpRequestFactory factory = new SimpleClientHttpRequestFactory();
		factory.setConnectTimeout(3000);
		factory.setReadTimeout(3000);
		return new RestTemplate(factory);
	}
	
	//private static final Logger log = LoggerFactory.getLogger(ApiGet.class);

//	private static final String URL_API_BOOKS = "https://itunes.apple.com/search?term=skrillex";

//@GetMapping("/find")
	// RestTemplate restTemplate = new RestTemplate();
	// ResponseEntity<Modelo[]> response =
	// restTemplate.getForEntity(URL_API_BOOKS,Modelo[].class);

	// System.out.println();
	// System.out.println("GET All StatusCode = " + response.getStatusCode());
	// System.out.println("GET All Headers = " + response.getHeaders());
	// System.out.println("GET Body (object list): ");
	// Arrays.asList(response.getBody())
	// .forEach(modelo -> System.out.println("--> " + modelo));

	// RestTemplate restTemplate;

	/*
	 * @GetMapping("/find/{nombre}") public String sayHello(@PathVariable("nombre")
	 * String nombre) { return "Hola " + nombre + ", ¿Cómo estas?"; }
	 */

	// public static void main(String[] args) {
	// SpringApplication.run(ApiGet.class, args);
	// }

	/*@Bean
	public RestTemplate restTemplate(RestTemplateBuilder builder) {
		return builder.build();
	}

	// @Bean
	@GetMapping("/find")
	public CommandLineRunner run(RestTemplate restTemplate) throws Exception {
		return args -> {
			Modelo modelo = restTemplate.getForObject("https://itunes.apple.com/search?term=skrillex", Modelo.class);
			log.info(modelo.toString());
		};
	}*/

	// @GetMapping("/loc")
	// public List<Modelo> getDatos() {
	// Modelo[] me =
	// restTemplate.getForObject("https://itunes.apple.com/search?term=skrillex",
	// Modelo[].class);
	// List<Modelo> m = Arrays.asList(me);
	// return m;
	// }

	/*
	 * 
	 * @GetMapping("/find") public List<Modelo> getModelos() { Modelo[] me =
	 * restTemplate.getForObject("https://itunes.apple.com/search?term=skrillex",
	 * Modelo[].class); List<Modelo> m = Arrays.asList(me); return m; }
	 */

	/*
	 * @GetMapping("/find/{nombre}") public List<Modelo>
	 * findDataByName(@PathVariable("nombre") String nombre) throws Exception {
	 * return Modelo modelo ;
	 * 
	 * }
	 */

	/*
	 * MODELO USADO POR EL INGE
	 * 
	 * @GetMapping("/find/{nombre}") public List<Data>
	 * findDataByName(@PathVariable("name") String name) throws Exceptions{ return
	 * serviceController.findDataByName(name); {
	 * 
	 */
	/*
	 * @Autowired ModeloRepository modeloRepository;
	 * 
	 * @RequestMapping("/find") public List<Modelo> getAllModelos() { List<Modelo>
	 * modelos = modeloRepository.findAll(); return modelos; }
	 */

}