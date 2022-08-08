package com.service.impl;


import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.mapper.ProductInfoMapper;
import com.pojo.ProductInfo;
import com.pojo.ProductInfoExample;
import com.pojo.vo.ProductInfoVo;
import com.service.ProductInfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ProductInfoServiceImpl implements ProductInfoService {

    //在业务逻辑层中,一定会有数据访问层的对象
    @Autowired
    ProductInfoMapper productInfoMapper;

    @Override
    public List<ProductInfo> getAll() {
        return productInfoMapper.selectByExample(new ProductInfoExample());
    }

    //select * from product_info limit 起始记录数=((当前页-1)*每页的条数),每页取几条
    //select * from product_info limit 10,5
    //select * from product limit ((pageNum-1)*pageSize,pageSize)
    @Override
    public PageInfo splitPage(int pageNum, int pageSize) {
        //分页插件使用PageHelper工具类完成分页设置
        PageHelper.startPage(pageNum, pageSize);

        //进行PageInfo的数据封装
        //进行有条件的查询操作,必须要创建ProductInfoExample对象
        ProductInfoExample example=new ProductInfoExample();

        //设置排序,按主键降序排序.
        //select * from product_info order by p_id desc
        example.setOrderByClause("p_id desc");

        //设置完排序后,取集合,切记切记:一定在取集合之前,设置PageHelper.startPage(pageNum,pageSize);
        List<ProductInfo> list=productInfoMapper.selectByExample(example);

        //将查询到的集合封装进PageInfo对象中
        PageInfo<ProductInfo> productInfoPageInfo = new PageInfo<>(list);

        return productInfoPageInfo;
    }

    @Override
    public int save(ProductInfo info) {

        return productInfoMapper.insert(info);
    }

    @Override
    public ProductInfo getById(int pid) {
        return productInfoMapper.selectByPrimaryKey(pid);
    }

    @Override
    public int update(ProductInfo info) {
        return productInfoMapper.updateByPrimaryKey(info);
    }

    @Override
    public int delete(int pid) {
        return productInfoMapper.deleteByPrimaryKey(pid);
    }

    @Override
    public int deleteBatch(String[] ids) {

        return productInfoMapper.deleteBatch(ids);
    }

    @Override
    public List<ProductInfo> selectCondition(ProductInfoVo vo) {
        return productInfoMapper.selectCondition(vo);

    }

    @Override
    public PageInfo<ProductInfo> splitPageVo(ProductInfoVo vo, int pageSize) {

        //分页插件使用PageHelper工具类完成分页设置
        PageHelper.startPage(vo.getPage(), pageSize);

        //将要查询的对象ProductInfo对象封装进集合中
        List<ProductInfo> list=productInfoMapper.selectCondition(vo);

        return new PageInfo<>(list);
    }


}







































































































