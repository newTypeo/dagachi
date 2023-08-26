package com.dagachi.app.club.entity;

import java.time.LocalDateTime;

import com.dagachi.app.club.common.Status;

import lombok.Data;

@Data
public class ClubGalleryAttachment {
	private int id;
	private int galleryId;
	private String originalFilename;
	private String renamedFilename;
	private LocalDateTime createdAt;
	private Status thumbnail;
}
