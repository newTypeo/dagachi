package com.dagachi.app.admin.repository;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import org.apache.ibatis.session.RowBounds;

import com.dagachi.app.admin.dto.AdminInquiryCreateDto;
import com.dagachi.app.admin.dto.AdminInquiryUpdateDto;
import com.dagachi.app.admin.entity.AdminInquiry;
import com.dagachi.app.admin.entity.MainPage;

@Mapper
public interface AdminRepository {
	
	@Select("select * from admin_Inquiry where inquiry_id = #{InquiryId}")
	AdminInquiry findInquiry(int inquiryId);

	@Update("UPDATE admin_Inquiry SET admin_id = #{adminId},response = #{response}, status = '1',response_at = sysdate WHERE Inquiry_id = #{inquiryId}")
	int updateInquiry(AdminInquiryUpdateDto inquiryUpdate);

	@Select("select * from main_page order by id desc fetch first 5 rows only")
	List<MainPage> getMainBanner();
	
	
	Map<String, Object> adminInquiryList(Map<String, Object> params);
	Map<String, Object> adminInquiryList(RowBounds rowBounds, Map<String, Object> params);

}
