package com.example.holaMundo.demo.Service;

import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/service")
@CrossOrigin
public class HolaMundo {

	@GetMapping("/holaMundo/{name}")
	public String sayHello(@PathVariable("name") String name) {
		return "Hola " + name + ", ¿Cómo estas?";
	}

}
