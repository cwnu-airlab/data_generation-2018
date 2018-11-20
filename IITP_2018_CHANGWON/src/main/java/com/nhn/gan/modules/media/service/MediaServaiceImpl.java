package com.nhn.gan.modules.media.service;

import java.io.BufferedReader;
import java.io.File;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.sql.Timestamp;
import java.util.Map;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.multipart.MultipartFile;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.nhn.gan.domain.MediaVo;
import com.nhn.gan.modules.media.dao.MediaDao;

public class MediaServaiceImpl implements MediaService {

	@Value("${file.media.uploadPath}")
	String mediaUploadPath;

	@Value("${file.media.dbInsertPath}")
	String mediaDbInsertPath;

	@Value("${media.video.makeThumbnail.url}")
	String videoMakeThumbnailUrl;

	@Autowired
	MediaDao mediaDao;

	@Override
	public int getMediaId() {
		return mediaDao.getMediaId();
	}

	public boolean registMediaFile(MultipartFile[] mfs, String userId) throws Exception {

		String catName = mediaDao.getNoneCategory();
		String uploadDirPath = mediaUploadPath + "/" + catName;
		String dbInsertPath = "/" + catName;
		File dirP = new File(uploadDirPath);
		if (!dirP.exists()) {
			dirP.mkdirs();
		}
		for (MultipartFile mf : mfs) {
			int mediaId = getMediaId();
			File mediaDir = new File(dirP.getPath(), String.valueOf(mediaId));
			if (!mediaDir.exists()) {
				mediaDir.mkdirs();
			}
			String fn = mf.getOriginalFilename();
			String ext = "";
			if (fn.lastIndexOf(".") != -1) {
				ext = fn.substring(fn.lastIndexOf("."));
			}
			String refineFn = mediaId + ext;
			File refineFile = new File(mediaDir.getParent(), refineFn);
			String videoDbInsertPath = dbInsertPath + "/" + mediaId + "/" + refineFn;
			String thumbnailDbInsertPath = dbInsertPath + "/" + mediaId + "/" + mediaId + ".png";
			File thumbNailPath = new File(mediaDir.getPath(), mediaId + ".png");
			InputStream in = null;
			try {
				in = mf.getInputStream();
				FileUtils.copyInputStreamToFile(in, refineFile);
			} catch (Exception e) {
				throw e;
			} finally {
				if (in != null) {
					try {
						in.close();
					} catch (Exception e) {
					}
				}
			}

			String json = makeVideoThumbNail(refineFile, thumbNailPath);
			Map<String, Object> map = new Gson().fromJson(json, Map.class); 
			MediaVo vo = new MediaVo();
			vo.setMediaId(mediaId);
			vo.setFileName(mf.getOriginalFilename());
			vo.setThumbNail(thumbnailDbInsertPath);
			vo.setLocalFile(videoDbInsertPath);
			vo.setDuration(Integer.parseInt(map.get("duration").toString()));
			vo.setTotalFrame(Integer.parseInt(map.get("totalFrame").toString()));
			vo.setRegistedUser(userId);
			vo.setRegDt(new Timestamp(System.currentTimeMillis()));
			// TODO DB insert까지
		}
		
		return true;
	}

	public boolean updateCategory(String beforeCategory, int newCategoryNo) {
		return false;
	}

	private String makeVideoThumbNail(File outputPath, File videoPath) {
		URL u = null;
		HttpURLConnection conn = null;
		try {
			u = new URL(videoMakeThumbnailUrl);
			conn = (HttpURLConnection) u.openConnection();
			conn.setDoOutput(true);

			JsonObject obj = new JsonObject();
			obj.addProperty("inputPath", videoPath.getPath());
			obj.addProperty("outPath", outputPath.getPath());

			OutputStream os = null;
			try {
				os = conn.getOutputStream();
				os.write(obj.toString().getBytes("UTF-8"));
			} catch (Exception e) {
				throw e;
			} finally {
				if (os != null) {
					os.close();
				}
			}
			conn.connect();
			StringBuffer sb = new StringBuffer();
			BufferedReader br = null;
			try {
				br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "utf-8"));
				String line = null;
				while((line = br.readLine()) != null) {
					sb.append(line);
				}
			} catch (Exception e) {
				throw e;
			} finally {
				if (os != null) {
					os.close();
				}
			}
			return sb.toString().trim();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (conn != null) {
				conn.disconnect();
			}
		}
		return "{}";
	}

}
