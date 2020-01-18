package com.zhengjian.hr.exception;

import com.zhengjian.hr.common.pojo.RespBean;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

import java.sql.SQLException;
import java.sql.SQLIntegrityConstraintViolationException;

@RestControllerAdvice
public class GlobalExceptionHandler {
    @ExceptionHandler(SQLException.class)
    public RespBean sqlException(SQLException e) {
        e.printStackTrace();
        RespBean respBean = RespBean.error("操作失败，数据库异常!");
        if (e instanceof SQLIntegrityConstraintViolationException) {
            return respBean.setMsg("操作失败，该数据有关联数据!");
        }
        return respBean;
    }
}