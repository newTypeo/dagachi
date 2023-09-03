package com.dagachi.app.club.entity;

import java.time.LocalDateTime;

import com.dagachi.app.club.common.Status;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.SuperBuilder;

@Data
@NoArgsConstructor
@AllArgsConstructor
@SuperBuilder
public class ClubGallery {
	private int galleryId;
	private int clubId;
	private String memberId;
	private int likeCount;
	private Status status;
}
