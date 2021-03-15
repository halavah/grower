package org.myslayers;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.scheduling.annotation.EnableScheduling;

@EnableScheduling//开启定时器
@SpringBootApplication
public class Application {

    public static void main(String[] args) {

        // 解决elasticsearch启动时，由于底层netty版本问题引发的项目启动问题
        System.setProperty("es.set.netty.runtime.available.processors", "false");

        SpringApplication.run(Application.class, args);
        System.out.println("http://localhost:8080");
    }
}


