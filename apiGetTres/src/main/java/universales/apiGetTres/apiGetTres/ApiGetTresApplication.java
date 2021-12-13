package universales.apiGetTres.apiGetTres;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.web.client.RestTemplateBuilder;
import org.springframework.context.annotation.Bean;
import org.springframework.web.client.RestTemplate;

@SpringBootApplication
public class ApiGetTresApplication {
	private static final Logger log = LoggerFactory.getLogger(ApiGetTresApplication.class);

	public static void main(String[] args) {
		SpringApplication.run(ApiGetTresApplication.class, args);
	}
	
	@Bean
	public RestTemplate restTemplate(RestTemplateBuilder builder) {
		return builder.build();
	}

	@Bean
	public CommandLineRunner run(RestTemplate restTemplate) throws Exception {
		return args -> {
			Quote quote = restTemplate.getForObject(
					"https://itunes.apple.com/search?term=jack+johnson&limit=1", Quote.class);
			log.info(quote.toString());
		};
	}

}
