package com.zhengjian.hr.common.util;

import com.zhengjian.hr.model.User;
import org.springframework.security.core.context.SecurityContextHolder;

/**
 * @Author zhengjian
 * @Date 2020/1/8 15:08
 */
public class UserUtils {
    public static User getCurUser() {
        return ((User) SecurityContextHolder.getContext().getAuthentication().getPrincipal());
    }

    public static Integer getCurUserId() {
        return getCurUser().getId();
    }
}
