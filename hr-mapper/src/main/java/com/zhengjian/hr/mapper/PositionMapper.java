package com.zhengjian.hr.mapper;

import com.zhengjian.hr.model.Position;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface PositionMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Position record);

    int insertSelective(Position record);

    Position selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Position record);

    int updateByPrimaryKey(Position record);

    int deleteByPrimaryKeys(@Param("ids") Integer[] ids);

    List<Position> getListAll();
}