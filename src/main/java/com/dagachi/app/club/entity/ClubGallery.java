package com.dagachi.app.club.entity;

import com.dagachi.app.club.common.Status;

import lombok.Data;

@Data
public class ClubGallery {
	private int galleryId;
	private int clubId;
	private String memberId;
	private int likeCount;
	private Status status;
}
