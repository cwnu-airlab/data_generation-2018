package com.nhn.gan.util.config.java;

import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.ImportResource;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;

@Configuration
@EnableWebSecurity
@ImportResource(locations="classpath:/config/spring/context-security.xml")
public class SecurityContext extends WebSecurityConfigurerAdapter {

}
