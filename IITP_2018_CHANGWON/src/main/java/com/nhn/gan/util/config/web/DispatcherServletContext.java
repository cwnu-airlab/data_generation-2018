package com.nhn.gan.util.config.web;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.FilterType;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartResolver;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;
import org.springframework.web.servlet.config.annotation.DefaultServletHandlerConfigurer;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;
import org.springframework.web.servlet.view.BeanNameViewResolver;
import org.springframework.web.servlet.view.JstlView;
import org.springframework.web.servlet.view.UrlBasedViewResolver;
import org.springframework.web.servlet.view.json.MappingJackson2JsonView;
import org.springframework.web.servlet.view.tiles3.TilesConfigurer;
import org.springframework.web.servlet.view.tiles3.TilesView;

import com.nhn.gan.common.interceptor.WebInterceptor;

/**
 * @author NHNEnt
 *
 */
@Configuration
@EnableWebMvc
@ComponentScan(basePackages = "com.nhn.gan", includeFilters = {
		@ComponentScan.Filter(type = FilterType.ANNOTATION, value = Controller.class),
		@ComponentScan.Filter(type = FilterType.ANNOTATION, value = RestController.class) }, excludeFilters = {
				@ComponentScan.Filter(type = FilterType.ANNOTATION, value = Service.class),
				@ComponentScan.Filter(type = FilterType.ANNOTATION, value = Repository.class),
				@ComponentScan.Filter(type = FilterType.ANNOTATION, value = Configuration.class) })
public class DispatcherServletContext extends WebMvcConfigurerAdapter {

	@Override
	public void addResourceHandlers(ResourceHandlerRegistry registry) {
		registry.addResourceHandler("/resources/**").addResourceLocations("/resources/");
	}

	@Override
	public void configureDefaultServletHandling(DefaultServletHandlerConfigurer configurer) {
		configurer.enable();
	}

	@Override
	public void addInterceptors(InterceptorRegistry registry) {
		registry.addInterceptor(new WebInterceptor()).addPathPatterns("/**");
	}

	@Bean(name = "jsonView")
	public MappingJackson2JsonView getJsonView() {
		return new MappingJackson2JsonView();
	}

	@Bean
	public BeanNameViewResolver getBeanNameViewResolver() {
		BeanNameViewResolver res = new BeanNameViewResolver();
		res.setOrder(0);
		return res;
	}

	@Bean(name = "viewResolver")
	public UrlBasedViewResolver getViewResolver() {
		UrlBasedViewResolver res = new UrlBasedViewResolver();
		res.setOrder(1);
		res.setViewClass(JstlView.class);
		res.setPrefix("/WEB-INF/views/");
		res.setSuffix(".jsp");

		return res;
	}

	@Bean(name = "tilesViewResolver")
	public UrlBasedViewResolver getTilesViewResolver() {
		UrlBasedViewResolver res = new UrlBasedViewResolver();
		res.setOrder(0);
		res.setViewClass(TilesView.class);
		return res;
	}

	@Bean(name = "tilesConfigurer")
	public TilesConfigurer getTilesConfigurer() {
		TilesConfigurer config = new TilesConfigurer();
		config.setDefinitions("classpath:config/tiles/tiles-config.xml");
		config.setCheckRefresh(true);
		return config;
	}

	@Bean(name = "multipartResolver")
	public MultipartResolver getMultipartResolver() {
		CommonsMultipartResolver res = new CommonsMultipartResolver();
		res.setMaxUploadSize(1000000000);
		return res;
	}
}
