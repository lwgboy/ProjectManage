package com.adtec.daily.controller.demand;

import com.adtec.daily.bean.demand.TDemandDetail;
import com.adtec.daily.service.demand.TDemandDetailService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * 处理项目CRUD请求
 */
@Controller
public class TDemandDetailController {

    @Autowired
    TDemandDetailService tDemandDetailService;

    /**
     * 检查项目编号是否可用
     *
     * @param tDemandDetail
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/getDemandDetail/{demandId}", method = RequestMethod.GET)
    public String getDemandDetail(TDemandDetail tDemandDetail, HttpServletRequest request) {
        System.out.println("请求体中的值：" + request.getParameter("demandId"));
        tDemandDetail.setDemandIds("DT00001");
        List<TDemandDetail> tddList = tDemandDetailService.getDemandDetail(tDemandDetail);
        return tddList.toString();
    }

}
