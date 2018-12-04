package com.nhn.gan.util.config.java;

import java.io.IOException;

import javax.sql.DataSource;

import org.apache.commons.dbcp2.BasicDataSource;
import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.io.support.PathMatchingResourcePatternResolver;

import net.sf.log4jdbc.Log4jdbcProxyDataSource;
import net.sf.log4jdbc.tools.Log4JdbcCustomFormatter;
import net.sf.log4jdbc.tools.LoggingType;

@Configuration
public class DataSourceContext {

	PathMatchingResourcePatternResolver pathMatching = new PathMatchingResourcePatternResolver();

	@Value("${database.driverClassName}")
	String driverClassName;

	@Value("${database.url}")
	String url;

	@Value("${database.username}")
	String username;

	@Value("${database.password}")
	String password;

	@Bean(name = "subDataSource", destroyMethod = "close")
	public DataSource getSubDataSource() {
		System.out.println(driverClassName);
		BasicDataSource ds = new BasicDataSource();
		ds.setDriverClassName(driverClassName);
		ds.setUrl(url);
		ds.setUsername(username);
		ds.setPassword(password);
		ds.setDefaultAutoCommit(false);
		ds.setTestWhileIdle(true);
		ds.setValidationQuery("select 1");
		ds.setTimeBetweenEvictionRunsMillis(30000);
		return ds;
	}

	@Bean(name = "dataSource")
	public DataSource getDateSource(DataSource subDataSource) {
		Log4jdbcProxyDataSource ds = new Log4jdbcProxyDataSource(subDataSource);
		Log4JdbcCustomFormatter formatter = new Log4JdbcCustomFormatter();
		formatter.setLoggingType(LoggingType.MULTI_LINE);
		formatter.setSqlPrefix("SQL\t:\n");
		ds.setLogFormatter(formatter);
		return ds;
	}

	@Bean(name = "sqlSession")
	public SqlSessionFactoryBean getSqlSessionFactoryBean(DataSource dataSource) throws IOException {
		SqlSessionFactoryBean fac = new SqlSessionFactoryBean();
		fac.setDataSource(dataSource);
		fac.setMapperLocations(pathMatching.getResources("classpath:/config/mapper/*_SQL.xml"));
		fac.setConfigLocation(pathMatching.getResource("classpath:/config/mybatis_config.xml"));
		return fac;
	}

	@Bean(name = "sqlSessionTemplate")
	public SqlSessionTemplate getSqlSessionTemplate(SqlSessionFactory sqlSession) throws Exception {
		SqlSessionTemplate template = new SqlSessionTemplate(sqlSession);
		return template;
	}

}
