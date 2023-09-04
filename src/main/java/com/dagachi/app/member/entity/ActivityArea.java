package com.dagachi.app.member.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.SuperBuilder;

@Data
@SuperBuilder
@NoArgsConstructor
@AllArgsConstructor // 활동 지역
public class ActivityArea extends Member{
   private String memberId; // 멤버아이디
   private String mainAreaId; //주 활동지역
   private String sub1AreaId; //서브지역
   private String sub2AreaId; //서브지역

}
 