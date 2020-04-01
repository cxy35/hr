package com.zhengjian.hr.service.system;

import com.zhengjian.hr.mapper.PositionMapper;
import com.zhengjian.hr.model.Position;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;

/**
 * @Author cxy35
 * @Date 2020/1/1 15:39
 */
@Service
public class PositionService {
    @Autowired
    PositionMapper positionMapper;

    public int add(Position position) {
        position.setCreateDate(new Date());
        position.setEnabled(true);
        return positionMapper.insertSelective(position);
    }

    public int deleteById(Integer id) {
       return positionMapper.deleteByPrimaryKey(id);
    }

    public int deleteByIds(Integer[] ids) {
        return positionMapper.deleteByPrimaryKeys(ids);
    }

    public int edit(Position position) {
        return positionMapper.updateByPrimaryKeySelective(position);
    }

    public List<Position> getListAll() {
        return positionMapper.getListAll();
    }
}
