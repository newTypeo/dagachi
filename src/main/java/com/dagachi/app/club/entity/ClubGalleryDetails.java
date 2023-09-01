package com.dagachi.app.club.entity;

import java.util.List;

import com.dagachi.app.member.entity.Member;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;
import lombok.experimental.SuperBuilder;
@Data
@SuperBuilder
@ToString(callSuper = true)
@NoArgsConstructor
@AllArgsConstructor
public class ClubGalleryDetails extends ClubGallery{

			private Member member;
			private List<ClubGalleryAttachment> attachments;
			
	
}
