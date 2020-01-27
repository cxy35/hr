package com.zhengjian.hr.mapper;

import com.zhengjian.hr.model.User;

import java.util.List;

public interface UserMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(User record);

    int insertSelective(User record);

    User selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(User record);

    int updateByPrimaryKey(User record);

    User loadUserByUsername(String username);

    /**
     * 根据 user 查询对象列表。如果指定 id ，则 sql 中增加 != id ，即排除当前用户。
     * @param user 作为查询条件的对象，为 null 则查询所有对象
     * @return 结果对象列表
     */
    List<User> getList(User user);

    /**
     * 根据 user 查询对象列表。如果指定 id ，则 sql 中增加 != id ，即排除当前用户。
     * @param user 作为查询条件的对象，为 null 则查询所有对象
     * @return 结果对象列表
     */
    List<User> getListWithRoles(User user);
}