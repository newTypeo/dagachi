package com.dagachi.app.club.entity;

import java.time.LocalDateTime;

import com.dagachi.app.club.common.Status;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ClubGalleryAttachment {
	
	private int id;
	private int galleryId;
	private String originalFilename;
	private String renamedFilename;
	private LocalDateTime createdAt;
	private Status thumbnail;
	
}
