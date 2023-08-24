package com.dagachi.app.admin.entity;

import java.time.LocalDateTime;

import lombok.Data;

@Data
public class MainPage {
	private int id;
	private String originalFilename;
	private String renamedFilename;
	private LocalDateTime createdAt;
}
