package org.myslayers.controller;

import org.myslayers.common.lang.Result;
import org.myslayers.service.impl.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class AuthController {
    @Autowired
    private UserService userService;
    
    @GetMapping("/")
    public Result index() {
        return Result.success("操作成功！", userService.list());
    }
}
