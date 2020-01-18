package com.zhengjian.hr.service.employee;

import com.zhengjian.hr.mapper.NationMapper;
import com.zhengjian.hr.model.Nation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @Author zhengjian
 * @Date 2020/1/13 14:33
 */
@Service
public class NationService {
    @Autowired
    NationMapper nationMapper;

    public List<Nation> getListAll() {
        return nationMapper.getListAll();
    }
}
