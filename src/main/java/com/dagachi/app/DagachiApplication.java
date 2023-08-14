package com.dagachi.app;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.EnableAspectJAutoProxy;

@SpringBootApplication
@EnableAspectJAutoProxy
public class DagachiApplication {

	public static void main(String[] args) {
		SpringApplication.run(DagachiApplication.class, args);
	}

}
