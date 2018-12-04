package com.nhn.gan;

import java.util.HashSet;
import java.util.Set;

import javax.servlet.FilterRegistration;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.SessionTrackingMode;

import org.springframework.security.web.session.HttpSessionEventPublisher;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.AnnotationConfigWebApplicationContext;
import org.springframework.web.filter.CharacterEncodingFilter;
import org.springframework.web.filter.DelegatingFilterProxy;
import org.springframework.web.servlet.support.AbstractDispatcherServletInitializer;

import com.nhn.gan.util.config.java.RootContext;
import com.nhn.gan.util.config.web.DispatcherServletContext;

public class GanInitionalizer extends AbstractDispatcherServletInitializer {

	@Override
	protected String[] getServletMappings() {
		return new String[] { "/" };
	}

	@Override
	protected WebApplicationContext createServletApplicationContext() {
		AnnotationConfigWebApplicationContext context = new AnnotationConfigWebApplicationContext();
		context.register(DispatcherServletContext.class);
		return context;
	}

	@Override
	protected WebApplicationContext createRootApplicationContext() {
		AnnotationConfigWebApplicationContext context = new AnnotationConfigWebApplicationContext();
		context.register(RootContext.class);
		return context;
	}

	@Override
	public void onStartup(ServletContext servletContext) throws ServletException {
		Set<SessionTrackingMode> modes = new HashSet<SessionTrackingMode>();
		modes.add(SessionTrackingMode.COOKIE);
		servletContext.setSessionTrackingModes(modes);
		HttpSessionEventPublisher sessionListener = new HttpSessionEventPublisher();
		servletContext.addListener(sessionListener);

		FilterRegistration.Dynamic encodingFilter = servletContext.addFilter("encodingFilter",
				CharacterEncodingFilter.class);
		encodingFilter.setInitParameter("encoding", "UTF-8");
		encodingFilter.setInitParameter("forceEncoding", "true");
		encodingFilter.addMappingForUrlPatterns(null, false, "*.do");
		FilterRegistration.Dynamic springSecurityFilterChain = servletContext.addFilter("springSecurityFilterChain",
				DelegatingFilterProxy.class);
		springSecurityFilterChain.addMappingForUrlPatterns(null, false, "/*");

		super.onStartup(servletContext);
	}

}
