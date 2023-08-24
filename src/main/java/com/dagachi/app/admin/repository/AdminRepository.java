package com.dagachi.app.admin.repository;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.dagachi.app.admin.dto.AdminInquiryCreateDto;
import com.dagachi.app.admin.dto.AdminInquiryUpdateDto;
import com.dagachi.app.admin.entity.MainPage;

@Mapper
public interface AdminRepository {
	
	@Select("select * from admin_Inquiry where inquiry_id = #{InquiryId}")
	AdminInquiryCreateDto findInquiry(int inquiryId);

	@Update("UPDATE admin_Inquiry SET admin_id = {memberId}, response = {response}, status = '1', response_at = sysdate, WHERE Inquiry_id = #{InquiryId}")
	int updateInquiry(AdminInquiryUpdateDto inquiryUpdate);

	@Select("select * from main_page order by id desc fetch first 5 rows only")
	List<MainPage> getMainBanner();

}
