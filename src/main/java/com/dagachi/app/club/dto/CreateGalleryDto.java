package com.dagachi.app.club.dto;

import com.dagachi.app.club.common.Status;

import lombok.Builder;
import lombok.Data;

@Builder
@Data
public class CreateGalleryDto {

	private int galleryId;
	private int clubId;
	private String memberId;
	private String renamedFilename;
	private Status status;
}
