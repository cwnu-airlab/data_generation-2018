package com.nhn.gan.modules.media.service;

import org.springframework.web.multipart.MultipartFile;

public interface MediaService {
	int getMediaId();

	public boolean updateCategory(String beforeCategory, int newCategoryNo);

	boolean registMediaFile(MultipartFile[] mfs, String userId) throws Exception;
}
