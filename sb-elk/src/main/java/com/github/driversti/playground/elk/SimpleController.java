package com.github.driversti.playground.elk;

import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@Slf4j
@RestController
public class SimpleController {

  @GetMapping("/hello")
  public String hello() {
    log.info("/hello called");
    return "Hello World!";
  }
}
