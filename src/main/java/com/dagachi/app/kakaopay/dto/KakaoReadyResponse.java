package com.dagachi.app.kakaopay.dto;

import lombok.Data;

@Data
public class KakaoReadyResponse {
	private String tid;
	private String next_redirect_pc_url;
	private String created_at;
}
