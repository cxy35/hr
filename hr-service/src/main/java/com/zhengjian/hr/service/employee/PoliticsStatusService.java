package com.zhengjian.hr.service.employee;

import com.zhengjian.hr.mapper.PoliticsStatusMapper;
import com.zhengjian.hr.model.PoliticsStatus;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @Author zhengjian
 * @Date 2020/1/13 14:34
 */
@Service
public class PoliticsStatusService {
    @Autowired
    PoliticsStatusMapper politicsStatusMapper;

    public List<PoliticsStatus> getListAll() {
        return politicsStatusMapper.getListAll();
    }
}
