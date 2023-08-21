package com.dagachi.app.club.dto;

import java.time.LocalDateTime;

import com.dagachi.app.club.common.Status;

import lombok.Data;

@Data
public class GalleryAndImageDto {
	
	private int galleryId;
	
	private int clubId;
	private int likeCount;
	private Status status;
	
	private int id;

	private String originalFilename;
	private String renamedFilename;
	private LocalDateTime createdAt;
	private Status thumbnail;
}
