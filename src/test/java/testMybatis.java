

import com.mapper.ProductInfoMapper;
import com.pojo.ProductInfo;

import com.pojo.vo.ProductInfoVo;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.List;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:applicationContext_dao.xml", "classpath:applicationContext_service.xml"})
public class testMybatis {

    @Autowired
    ProductInfoMapper productInfoMapper;

    @Test
    public void test()
    {
        ProductInfoVo vo = new ProductInfoVo();
        vo.setTypeid(1);
        List<ProductInfo> productInfoList = productInfoMapper.selectCondition(vo);
        for(ProductInfo p : productInfoList)
        {
            System.out.println(p.getpName());
        }
    }




}
