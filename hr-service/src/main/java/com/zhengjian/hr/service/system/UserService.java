package com.zhengjian.hr.service.system;

import com.zhengjian.hr.common.util.UserUtils;
import com.zhengjian.hr.mapper.RoleMapper;
import com.zhengjian.hr.mapper.UserMapper;
import com.zhengjian.hr.mapper.UserRoleMapper;
import com.zhengjian.hr.model.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * @Author zhengjian
 * @Date 2019/12/20 10:48
 */
@Service
public class UserService implements UserDetailsService {
    @Autowired
    UserMapper userMapper;
    @Autowired
    RoleMapper roleMapper;
    @Autowired
    UserRoleMapper userRoleMapper;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        User user = userMapper.loadUserByUsername(username);
        if (user == null) {
            throw new UsernameNotFoundException("用户名不存在！");
        }
        user.setRoles(roleMapper.getListByUserId(user.getId()));
        return user;
    }

    public int deleteById(Integer id) {
        return userMapper.deleteByPrimaryKey(id);
    }

    public int edit(User user) {
        return userMapper.updateByPrimaryKeySelective(user);
    }

    /**
     * 更新用户与角色，先根据 uid 删除所有，再新增
     *
     * @param uid  用户id
     * @param rids 角色id
     * @return
     */
    @Transactional
    public boolean editUserRole(Integer uid, Integer[] rids) {
        if (uid == null) {
            return false;
        }
        userRoleMapper.deleteByUid(uid);
        if (rids == null || rids.length == 0) {
            return true;
        }
        int r = userRoleMapper.insertByUidAndRids(uid, rids);
        return r == rids.length;
    }

    public List<User> getList(User user) {
        if (user == null) {
            user = new User();
        }
        user.setId(UserUtils.getCurUserId());// 排除当前用户
        List<User> list = userMapper.getList(user);
        return list;
    }

    public List<User> getListWithRoles(User user) {
        if (user == null) {
            user = new User();
        }
        user.setId(UserUtils.getCurUserId());// 排除当前用户
        List<User> list = userMapper.getListWithRoles(user);
        return list;
    }

}
