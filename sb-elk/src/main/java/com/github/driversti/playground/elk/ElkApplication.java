package com.github.driversti.playground.elk;

//import co.elastic.apm.attach.ElasticApmAttacher;

import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

import java.time.LocalDateTime;
import java.util.Timer;
import java.util.TimerTask;

@Slf4j
@SpringBootApplication
public class ElkApplication {

  public static void main(String[] args) {
//    ElasticApmAttacher.attach();
    SpringApplication.run(ElkApplication.class, args);
    new Timer().schedule(new TimePrinter(), 0, 1000);
  }

  private static class TimePrinter extends TimerTask {
    public void run() {
      log.info(LocalDateTime.now().toString().replace("T", " ").substring(0, 19));
    }
  }
}
