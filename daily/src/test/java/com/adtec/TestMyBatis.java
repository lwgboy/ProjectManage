package com.adtec;

import com.adtec.daily.bean.project.Project;
import com.adtec.daily.service.project.ProjectService;
import com.alibaba.fastjson.JSON;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;

/**
 * File: TestMyBatis
 *
 * @Author 王林柱
 * @Since 2017/12/29 14:16
 * @Ver 1.0
 */

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = "classpath:spring.xml")
//------------如果加入以下代码，所有继承该类的测试类都会遵循该配置，也可以不加，在测试类的方法上///控制事务，参见下一个实例
//这个非常关键，如果不加入这个注解配置，事务控制就会完全失效！
//@Transactional
//这里的事务关联到配置文件中的事务控制器（transactionManager = "transactionManager"），同时//指定自动回滚（defaultRollback = true）。这样做操作的数据才不会污染数据库！
@Transactional(transactionManager = "transactionManager",readOnly = true)

public class TestMyBatis {
    static Logger logger = LogManager.getLogger(LogManager.ROOT_LOGGER_NAME);

    @Resource
    private ProjectService projectService;

    @Test
    public void test1(){
        Project project = projectService.getProject(25);
        logger.info(JSON.toJSONString(project));
    }


}
