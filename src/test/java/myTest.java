import com.mapper.ProductInfoMapper;
import com.pojo.ProductInfo;
import com.pojo.vo.ProductInfoVo;
import com.utils.MD5Util;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import java.util.List;

public class myTest {
    @Test
    public void testMD5(){
        String md5 = MD5Util.getMD5("000000");
        System.out.println(md5);
    }

}






































































