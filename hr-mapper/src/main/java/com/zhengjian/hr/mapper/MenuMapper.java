package com.zhengjian.hr.mapper;

import com.zhengjian.hr.model.Menu;

import java.util.List;

public interface MenuMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Menu record);

    int insertSelective(Menu record);

    Menu selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Menu record);

    int updateByPrimaryKey(Menu record);

    List<Menu> getListByUserId(Integer userId);

    List<Menu> getListAllWithRoles();

    List<Menu> getListAllWithChildren();

}