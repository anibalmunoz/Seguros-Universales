package universales.apiGetDos.Service;

import java.util.Arrays;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.client.RestTemplate;

//@Service
public class Service {
	
	@Autowired
	RestTemplate restTemplate;
	
	
	 public List<Modelo> getDatos(){
	        ResponseEntity<Modelo[]> response =
	                  restTemplate.getForEntity(
	                  "https://itunes.apple.com/search?term=skrillex",
	                  Modelo[].class);
	                Modelo[] modelos = response.getBody();
	                List<Modelo> m = Arrays.asList(modelos);
	        return  m;
	    }
	
}
