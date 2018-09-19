package com.example.web.controller;

import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;

@Controller
public class HelloController {

    @RequestMapping(value = "/", method = RequestMethod.GET)
    @ResponseStatus(value = HttpStatus.OK)
    public String printWelcome() {
        return "welcome";
    }

    @RequestMapping(value = "/checkpreload.htm", method = RequestMethod.GET)
    @ResponseBody
    public String printSuccess() {
        return "success";
    }
}
