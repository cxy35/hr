package com.zhengjian.hr.mapper;

import com.zhengjian.hr.model.UserRole;
import org.apache.ibatis.annotations.Param;

public interface UserRoleMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(UserRole record);

    int insertSelective(UserRole record);

    UserRole selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(UserRole record);

    int updateByPrimaryKey(UserRole record);

    int deleteByUid(Integer uid);

    int insertByUidAndRids(@Param("uid") Integer uid, @Param("rids") Integer[] rids);
}