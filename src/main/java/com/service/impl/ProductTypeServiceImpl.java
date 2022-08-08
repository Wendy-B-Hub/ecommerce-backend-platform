package com.service.impl;

import com.mapper.ProductTypeMapper;
import com.pojo.ProductType;
import com.pojo.ProductTypeExample;
import com.service.ProductTypeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service("ProductTypeServiceImpl")
public class ProductTypeServiceImpl implements ProductTypeService {

    @Autowired
    //在业务逻辑层一定会有数据访问层的对象
    ProductTypeMapper productTypeMapper;

    @Override
    public List<ProductType> getAll() {

        return productTypeMapper.selectByExample(new ProductTypeExample());

    }


}























