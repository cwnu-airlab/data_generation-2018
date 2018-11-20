package com.nhn.gan.util.config.java;

import java.io.IOException;

import org.springframework.beans.factory.config.PropertiesFactoryBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.FilterType;
import org.springframework.context.annotation.Import;
import org.springframework.context.support.PropertySourcesPlaceholderConfigurer;
import org.springframework.core.io.Resource;
import org.springframework.core.io.support.PathMatchingResourcePatternResolver;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RestController;

@Configuration
@ComponentScan(
		basePackages="com.nhn.gan",
		includeFilters= {
				@ComponentScan.Filter(type=FilterType.ANNOTATION, value=Service.class),
				@ComponentScan.Filter(type=FilterType.ANNOTATION, value=Repository.class)
		},
		excludeFilters= {
				@ComponentScan.Filter(type=FilterType.ANNOTATION, value=Controller.class),
				@ComponentScan.Filter(type=FilterType.ANNOTATION, value=RestController.class),
				@ComponentScan.Filter(type=FilterType.ANNOTATION, value=Configuration.class)
		}
)
@Import(value = { CommonContext.class, DataSourceContext.class,  SecurityContext.class})
public class RootContext {

	PathMatchingResourcePatternResolver pathMatching = new PathMatchingResourcePatternResolver();
	
	@Bean
	public PropertySourcesPlaceholderConfigurer  getPropertyPlaceholderConfigurer() throws IOException {
		PropertySourcesPlaceholderConfigurer  ppc = new PropertySourcesPlaceholderConfigurer ();
		Resource[] resources = pathMatching.getResources("classpath:/application_dev.properties");
//		Resource[] resources = pathMatching.getResources("classpath:/application.properties");
		ppc.setLocations(resources);
//		ppc.setIgnoreUnresolvablePlaceholders(true);
		return ppc;
	}
	
	
	@Bean(name="app")
	public PropertiesFactoryBean getGlobalSettings() throws IOException {
		PropertiesFactoryBean bean = new PropertiesFactoryBean();
		bean.setLocations(pathMatching.getResources("classpath:/global.settings_dev.properties"));
//		bean.setLocations(pathMatching.getResources("classpath:/global.settings.properties"));
		return bean;
	}
}
