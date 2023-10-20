/*
 * Copyright (C), 2008-2021, xxx All Rights Reserved.
 */
package com.xxx.admin.web.apply;

import com.xxx.common.dto.IdsDTO;
import com.xxx.error.common.Response;
import com.xxx.idm.client.apply.client.RequestLogClient;
import com.xxx.idm.client.cer.request.RequestLogConditionDTO;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;

/**
 * <p>
 * 下推任务调度表 前端控制器
 * </p>
 *
 * @author zy
 * @since  2020-04-17
 */
@SuppressWarnings({ "rawtypes" })
@RequestMapping("/apply")
@RestController
@Slf4j
public class RequestLogController {
    @Resource
    private RequestLogClient requestLogClient;
    /**
     * <p>
     * 分页查询
     * </p>
     *
     * @param  condition 查询条件
     * @return           分页数据
     */
    @PostMapping("/list")
    Response list(@RequestBody RequestLogConditionDTO condition) {
        return requestLogClient.list(condition);
    }

    /**
     * <p>
     * 失败请求重新提交
     * </p>
     *
     * @param  ids 一个或多个id字符串
     * @return
     */
    @PostMapping("/retry")
    Response retry(@RequestBody IdsDTO ids) {
        return requestLogClient.retry(ids);
    }

    /**
     * <p>
     * 关闭失败的请求
     * </p>
     *
     * @param  ids 一个或多个id字符串
     * @return
     */
    @PostMapping("/confirm")
    Response confirm(@RequestBody IdsDTO ids) {
        return requestLogClient.confirm(ids);
    }

    /**
     * <p>
     * 获取任务执行的详情清单
     * </p>
     *
     * @param  id 任务表的请求id
     * @return    分页数据
     */
    @GetMapping("/history/list/{id}")
    Response listItem(@PathVariable("id") Long id) {
        return requestLogClient.listItem(id);
    }

    /**
     * <p>
     * 获取错误日志
     * </p>
     *
     * @param  requestLogItemId request_log_item表的id字段值
     * @return
     */
    @GetMapping("/errorMsg/{requestLogItemId}")
    Response getErrorMsg(@PathVariable("requestLogItemId") Long requestLogItemId) {
        return requestLogClient.getErrorMsg(requestLogItemId);
    }

    /**
     * <p>
     * 获取任务的实体
     * </p>
     *
     * @param  requestLogItemId request_log_item表的id字段值
     * @return
     */
    @GetMapping("/entity/{requestLogItemId}")
    Response getEntity(@PathVariable("requestLogItemId") Long requestLogItemId) {
        return requestLogClient.getEntity(requestLogItemId);
    }

    /**
     * <p>
     * 获取下推报文
     * </p>
     *
     * @param  requestLogItemId request_log_item表的id字段值
     * @return
     */
    @GetMapping("/message/{requestLogItemId}")
    Response getMessage(@PathVariable("requestLogItemId") Long requestLogItemId) {
        return requestLogClient.getMessage(requestLogItemId);
    }

    /**
     * <p>
     * 获取响应报文
     * </p>
     *
     * @param  requestLogItemId request_log_item表的id字段值
     * @return
     */
    @GetMapping("/response-message/{requestLogItemId}")
    Response getResponseMessage(@PathVariable("requestLogItemId") Long requestLogItemId) {
        return requestLogClient.getResponseMessage(requestLogItemId);
    }
}
