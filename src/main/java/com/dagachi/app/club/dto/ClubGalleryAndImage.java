package com.dagachi.app.club.dto;

import java.time.LocalDateTime;

import lombok.Data;
@Data
public class ClubGalleryAndImage {

	private int galleryId;
	private int clubId;
	private String memberId;
	private int likeCount;
	private String status;
	private int id; // attachment id임
	private String originalFilename;
	private String renamedFilename;
	private LocalDateTime createdAt;
	private String thumbNail;
}
