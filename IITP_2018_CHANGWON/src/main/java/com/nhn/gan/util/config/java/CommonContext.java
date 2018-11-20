package com.nhn.gan.util.config.java;

import java.io.IOException;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.core.io.support.PathMatchingResourcePatternResolver;
import org.springframework.web.multipart.MultipartResolver;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;

import com.nhn.gan.modules.learning.view.DownloadTextView;

@Configuration
public class CommonContext {
	
	PathMatchingResourcePatternResolver pathMatching = new PathMatchingResourcePatternResolver();
	
	@Bean(name="downloadTextView")
	public DownloadTextView getDownloadTextView() {
		return new DownloadTextView();
	}
	
	
	@Bean(name="multipartResolver")
	public MultipartResolver getMultipartResolver(Resource fileSystemResource) throws IOException {
		CommonsMultipartResolver res = new CommonsMultipartResolver();
		res.setMaxUploadSize(50000000l);
		res.setUploadTempDir(fileSystemResource);
		return res;
	}
	
	@Value("${file.uploadPath}")
	String uploadPath;
	
	@Bean(name="fileSystemResource")
	public Resource getFileSystemResource() {
		System.out.println(uploadPath);
		FileSystemResource res = new FileSystemResource(uploadPath);
		return res;
	}
}
