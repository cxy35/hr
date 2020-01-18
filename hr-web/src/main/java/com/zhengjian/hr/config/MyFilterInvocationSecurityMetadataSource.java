package com.zhengjian.hr.config;

import com.zhengjian.hr.model.Menu;
import com.zhengjian.hr.model.Role;
import com.zhengjian.hr.service.system.MenuService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.ConfigAttribute;
import org.springframework.security.access.SecurityConfig;
import org.springframework.security.web.FilterInvocation;
import org.springframework.security.web.access.intercept.FilterInvocationSecurityMetadataSource;
import org.springframework.stereotype.Component;
import org.springframework.util.AntPathMatcher;

import java.util.Collection;
import java.util.List;

/**
 * @Author zhengjian
 * @Date 2019/12/31 10:49
 */
@Component
public class MyFilterInvocationSecurityMetadataSource implements FilterInvocationSecurityMetadataSource {
    @Autowired
    MenuService menuService;

    AntPathMatcher antPathMatcher = new AntPathMatcher();

    @Override
    public Collection<ConfigAttribute> getAttributes(Object object) throws IllegalArgumentException {
        // 根据请求地址，分析出该请求需要的角色
        String requestUrl = ((FilterInvocation) object).getRequestUrl();
        List<Menu> allMenus = menuService.getListAllWithRoles();
        for (Menu menu : allMenus) {
            if (antPathMatcher.match(menu.getUrl(), requestUrl)) {
                List<Role> roles = menu.getRoles();
                String[] roleNameArr = new String[roles.size()];
                for (int i = 0; i < roles.size(); i++) {
                    roleNameArr[i] = roles.get(i).getName();
                }
                // 将返回值带入 MyAccessDecisionManager 执行之后的判断
                return SecurityConfig.createList(roleNameArr);
            }
        }

        // 请求未匹配时返回一个特殊的角色名，表示需要登录后才能访问
        return SecurityConfig.createList("ROLE_LOGIN");
    }

    @Override
    public Collection<ConfigAttribute> getAllConfigAttributes() {
        return null;
    }

    @Override
    public boolean supports(Class<?> clazz) {
        return true;
    }
}
