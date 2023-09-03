package com.dagachi.app.member.dto;

import java.time.LocalDate;
import java.util.List;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.NotEmpty; // @NotEmpty 어노테이션 추가

import org.springframework.format.annotation.DateTimeFormat;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class MemberKakaoUpdateDto {

    @NotBlank(message = "닉네임은 필수입니다.")
    private String nickname;// 닉네임 

    @NotBlank(message = "핸드폰 번호는 필수입니다.")
    private String phoneNo;    // 핸드폰 

    @NotBlank(message = "이메일은 필수입니다.")
    private String email;    // 이메일 

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private LocalDate birthday;// 생일 

    @NotBlank(message = "mbti는 필수입니다.")
    private String mbti;// mbti 

    @NotBlank(message = "주소는 필수입니다.")
    private String activityArea;// 주소 

    @NotBlank(message = "성별 필수입니다.")
    private String gender;// 성별 

    @NotBlank(message = "활동지역 필수입니다.")
    private String mainAreaId; // 주 활동 지역

    @NotEmpty(message = "관심사는 필수입니다.") // @NotEmpty로 수정
    private List<String> interest;// 관심사
}
