package com.zhengjian.hr.service.system;

import com.zhengjian.hr.mapper.MenuRoleMapper;
import com.zhengjian.hr.mapper.RoleMapper;
import com.zhengjian.hr.model.Role;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * @Author zhengjian
 * @Date 2020/1/2 14:24
 */
@Service
public class RoleService {
    @Autowired
    RoleMapper roleMapper;
    @Autowired
    MenuRoleMapper menuRoleMapper;

    public int add(Role role) {
        if (!role.getName().startsWith("ROLE_")) {
            role.setName("ROLE_" + role.getName());
        }
        return roleMapper.insertSelective(role);
    }

    public int deleteById(Integer id) {
        return roleMapper.deleteByPrimaryKey(id);
    }

    /**
     * 更新角色与菜单，先根据 rid 删除所有，再新增
     *
     * @param rid  角色id
     * @param mids 菜单id
     * @return
     */
    @Transactional
    public boolean editRoleMenu(Integer rid, Integer[] mids) {
        if (rid == null) {
            return false;
        }
        menuRoleMapper.deleteByRid(rid);
        if (mids == null || mids.length == 0) {
            return true;
        }
        int r = menuRoleMapper.insertByRidAndMids(rid, mids);
        return r == mids.length;
    }

    public List<Role> getListAll() {
        return roleMapper.getListAll();
    }

    public List<Integer> getMidsByRid(Integer rid) {
        return menuRoleMapper.getMidsByRid(rid);
    }
}
