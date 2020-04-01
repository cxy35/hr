package com.zhengjian.hr.service.system;

import com.zhengjian.hr.common.util.UserUtils;
import com.zhengjian.hr.mapper.MenuMapper;
import com.zhengjian.hr.mapper.MenuRoleMapper;
import com.zhengjian.hr.model.Menu;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.CacheConfig;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @Author cxy35
 * @Date 2019/12/26 12:09
 */
@Service
@CacheConfig(cacheNames = "cache_menus")
public class MenuService {
    @Autowired
    MenuMapper menuMapper;
    @Autowired
    MenuRoleMapper menuRoleMapper;

    /**
     * 获取当前用户的菜单
     *
     * @return
     */
    public List<Menu> getListForCurUser() {
        return menuMapper.getListByUserId(UserUtils.getCurUserId());
    }

    /**
     * 获取所有菜单
     *
     * @return
     */
    // @Cacheable
    public List<Menu> getListAllWithRoles() {
        return menuMapper.getListAllWithRoles();
    }

    public List<Menu> getListAllWithChildren() {
        return menuMapper.getListAllWithChildren();
    }

}
