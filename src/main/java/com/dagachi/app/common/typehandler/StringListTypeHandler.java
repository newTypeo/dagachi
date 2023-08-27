package com.dagachi.app.common.typehandler;

import java.sql.CallableStatement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Arrays;
import java.util.List;

import org.apache.ibatis.type.BaseTypeHandler;
import org.apache.ibatis.type.JdbcType;
import org.apache.ibatis.type.MappedJdbcTypes;
import org.apache.ibatis.type.MappedTypes;

@MappedTypes(List.class)
@MappedJdbcTypes(JdbcType.VARCHAR)
//타입으로 데이터를 읽고 쓰기 위한 사용자 정의 타입 핸들러
public class StringListTypeHandler extends BaseTypeHandler<List<String>> {

	@Override
	//문자열을 콤마로 구분된 값으로 나누어 List<String>으로 변환
	public void setNonNullParameter(PreparedStatement ps, int i, List<String> parameter, JdbcType jdbcType)
			throws SQLException {
		String value = "";
		for(int j = 0; j < parameter.size(); j++) {
			value += parameter.get(j);
			if(j != parameter.size() - 1) 
				value += ",";
		}
		ps.setString(i, value);
	}

	@Override
	//데이터베이스에서 읽은 결과 집합(ResultSet)에서 특정 열(columnName에 해당하는 열)의 값을 읽어와서 Java List<String>으로 변환하는 역할
	public List<String> getNullableResult(ResultSet rs, String columnName) throws SQLException {
		String value = rs.getString(columnName);
		if(value != null) {
			String[] values = value.split(",");
			return Arrays.asList(values);
		}
		return null;
	}

	@Override
	// 데이터베이스에서 읽은 결과 집합(ResultSet)에서 특정 열(columnIndex에 해당하는 열)의 값을 읽어와서 Java List<String>으로 변환하는 역할
	public List<String> getNullableResult(ResultSet rs, int columnIndex) throws SQLException {
		String value = rs.getString(columnIndex);
		if(value != null) {
			String[] values = value.split(",");
			return Arrays.asList(values);
		}
		return null;
	}

	@Override
	// 데이터베이스로부터 결과를 가져오는 CallableStatement에서 특정 열(columnIndex에 해당하는 열)의 값을 읽어와서 Java List<String>으로 변환하는 역할
	public List<String> getNullableResult(CallableStatement cs, int columnIndex) throws SQLException {
		String value = cs.getString(columnIndex);
		if(value != null) {
			String[] values = value.split(",");
			return Arrays.asList(values);
		}
		return null;
	}

}
