package com.zhengjian.hr.mapper;

import com.zhengjian.hr.model.MenuRole;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface MenuRoleMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(MenuRole record);

    int insertSelective(MenuRole record);

    MenuRole selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(MenuRole record);

    int updateByPrimaryKey(MenuRole record);

    int deleteByRid(Integer rid);

    int insertByRidAndMids(@Param("rid") Integer rid, @Param("mids") Integer[] mids);

    List<Integer> getMidsByRid(@Param("rid") Integer rid);
}