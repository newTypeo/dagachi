package com.dagachi.app.club.dto;

import javax.validation.Valid;
import javax.validation.constraints.NotBlank;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Valid
public class ClubReportDto {
	private int clubId;
	@NotBlank(message = "할일을 작성해주세요.")
	private String reason;
	private String reporter;
}
