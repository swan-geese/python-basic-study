package com.xxx.admin.web.apply;

import com.xxx.common.dto.ConditionFilterDTO;
import com.xxx.error.common.Response;
import com.xxx.idm.client.apply.client.RequestLogPermissionLinkClient;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;

/**
 * <p>
 * 下推任务调度表权限变更关联表 前端控制器
 * </p>
 *
 * @author zy
 * @since  2023-06-16
 */
@SuppressWarnings({ "rawtypes" })
@RequestMapping("/apply/permission")
@RestController
@Slf4j
public class RequestLogPermissionLinkController {

    @Resource
    private RequestLogPermissionLinkClient requestLogPermissionLinkClient;
    /**
     * <p>
     * 获取任务执行的相关的权限详情列表
     * </p>
     *
     * @param  dto 任务表的请求id,分页条件
     * @return     分页数据
     */
    @PostMapping("/list")
    Response listItem(@RequestBody ConditionFilterDTO dto) {
        return requestLogPermissionLinkClient.listItem(dto);
    }
}
