package com.nhn.gan.modules.media.service;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileFilter;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.sql.Timestamp;
import java.text.NumberFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.nhn.gan.domain.MediaCategoryVo;
import com.nhn.gan.domain.MediaShotVo;
import com.nhn.gan.domain.MediaTagDescVo;
import com.nhn.gan.domain.MediaVo;
import com.nhn.gan.modules.media.dao.MediaDao;

@Service("mediaService")
public class MediaServaiceImpl implements MediaService {

	Logger logger = LoggerFactory.getLogger(getClass());

	@Value("${file.media.uploadPath}")
	String mediaUploadPath;

	@Value("${file.media.dbInsertPath}")
	String mediaDbInsertPath;

	@Value("${media.video.makeThumbnail.url}")
	String videoMakeThumbnailUrl;

	@Value("${media.shot.frameInfo.url}")
	String videoMakeShotUrl;

	@Autowired
	MediaDao mediaDao;

	public FileFilter fileTypeFilter = new FileFilter() {

		@Override
		public boolean accept(File pathname) {
			if (pathname.isFile()) {
				return true;
			}
			return false;
		}
	};

	@Override
	public int getMediaId() {
		return mediaDao.getMediaId();
	}

	NumberFormat format = NumberFormat.getInstance();

	public boolean registMediaFile(MultipartFile[] mfs, String userId, String chkInfo, HttpSession session)
			throws Exception {

		String catName = mediaDao.getNoneCategory();
		String uploadDirPath = mediaUploadPath + "/uploads/" + catName;
		String dbInsertPath = mediaDbInsertPath + "/uploads/" + catName;
		File dirP = new File(uploadDirPath);
		if (!dirP.exists()) {
			dirP.mkdirs();
		}
		session.setAttribute(chkInfo, "동영상 파일 업로드를 진행합니다.");
		int index = 1;
		int length = mfs.length;
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
			File refineFile = new File(mediaDir, refineFn);
			String videoDbInsertPath = dbInsertPath + "/" + mediaId + "/" + refineFn;
			String thumbnailDbInsertPath = dbInsertPath + "/" + mediaId + "/" + mediaId + ".png";
			File thumbNailPath = new File(mediaDir, mediaId + ".png");

			InputStream in = null;
			OutputStream out = null;
			byte[] buffer = new byte[2048];
			long fileSize = mf.getSize();
			long uploadSize = 0;
			double progress = 0.0;
			session.setAttribute(chkInfo, String.format("(%d / %d) %s 업로드 시작", index, length, fn, progress));
			try {
				in = mf.getInputStream();
				out = new FileOutputStream(refineFile);
				int len = 0;
				while ((len = in.read(buffer)) > 0) {
					out.write(buffer, 0, len);
					uploadSize += len;
					progress = Math.round(((double) uploadSize / (double) fileSize) * 100);
					session.setAttribute(chkInfo,
							String.format("(%d / %d) %s 업로드 진행중 (진행률 : %.2f%%)", index, length, fn, progress));
				}
			} catch (Exception e) {
				throw e;
			} finally {
				if (in != null) {
					try {
						in.close();
					} catch (Exception e) {
					}
				}
				if (out != null) {
					try {
						out.close();
					} catch (Exception e) {
					}
				}
			}
			session.setAttribute(chkInfo,
					String.format("(%d / %d) %s 업로드 완료 (진행률 : %.2f%%)", index, length, fn, progress));

			session.setAttribute(chkInfo, String.format("(%d / %d) %s ==> 동영상 분석 작업 시작", index, length, fn));
			String json = makeVideoThumbNail(refineFile, thumbNailPath);
			Map<String, Object> map = new Gson().fromJson(json, Map.class);
			System.out.println(map);
			MediaVo vo = new MediaVo();
			vo.setMediaId(mediaId);
			vo.setCategory(1);
			vo.setFileName(fn);
			vo.setThumbNail(thumbnailDbInsertPath);
			vo.setLocalFile(videoDbInsertPath);
			String duration = map.get("duration").toString();
			if (duration == null) {
				duration = "0.0";
			}
			vo.setDuration((int) Double.parseDouble(duration));
			vo.setTotalFrame(Integer.parseInt(map.get("totalFrame").toString()));
			vo.setRegistedUser(userId);
			vo.setRegDt(new Timestamp(System.currentTimeMillis()));
			// TODO DB insert까지
			mediaDao.insertMedia(vo);
			session.setAttribute(chkInfo, String.format("업로드 진행상황 : (%d / %d) %s ==> 동영상 분석 작업 완료", index, length, fn));
			index++;
		}
		session.setAttribute(chkInfo, "동영상 파일 업로드를 완료하였습니다.");
		return true;
	}

	private String makeVideoThumbNail(File videoPath, File outputPath) {
		URL u = null;
		HttpURLConnection conn = null;
		try {
			u = new URL(videoMakeThumbnailUrl);
			conn = (HttpURLConnection) u.openConnection();
			conn.setDoOutput(true);
			conn.setRequestProperty("Content-Type", "application/json");
			JsonObject obj = new JsonObject();
			obj.addProperty("inputPath", videoPath.getPath());
			obj.addProperty("outputPath", outputPath.getPath());

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
				while ((line = br.readLine()) != null) {
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

	@Override
	public int selectMediaInfoCount(MediaVo vo) {
		return mediaDao.selectMediaInfoCount(vo);
	}

	@Override
	public List<MediaVo> selectMediaInfoList(MediaVo vo) {
		return mediaDao.selectMediaInfoList(vo);
	}

	@Override
	public MediaVo getMediaInfo(int mediaId) {
		MediaVo res = mediaDao.selectMediaInfo(mediaId);
		List<MediaShotVo> shotInfo = mediaDao.selectShotMediaActivity(mediaId);
		List<MediaTagDescVo> tagDescInfo = mediaDao.selectMediaTagDesc(mediaId);

		// 키 => mid_sId_tagId
		Map<String, MediaTagDescVo> tagSearchInfo = new HashMap<>();
		for (MediaTagDescVo vo : tagDescInfo) {
			tagSearchInfo.put(vo.makeTagKey(), vo);
		}

		System.out.println(tagSearchInfo);
		for (MediaShotVo vo : shotInfo) {
			String who = vo.getWhoTagId();
			if (tagSearchInfo.containsKey(who)) {
				MediaTagDescVo whoTag = tagSearchInfo.get(who);
				vo.setWhoTagInfo(whoTag);
			}

			String whatBehavior = vo.getWhatBehaviorTagId();
			if (tagSearchInfo.containsKey(whatBehavior)) {
				MediaTagDescVo whatBehaviorTag = tagSearchInfo.get(whatBehavior);
				vo.setWhatBehaviorTagInfo(whatBehaviorTag);
			}

			String whatObject = vo.getWhatObjectTagId();
			if (tagSearchInfo.containsKey(whatObject)) {
				MediaTagDescVo whatObjectTag = tagSearchInfo.get(whatObject);
				vo.setWhatObjectTagInfo(whatObjectTag);
			}

			String where = vo.getWhereTagId();
			if (tagSearchInfo.containsKey(where)) {
				MediaTagDescVo whereTag = tagSearchInfo.get(where);
				vo.setWhereTagInfo(whereTag);
			}

			String when = vo.getWhenTagId();
			if (tagSearchInfo.containsKey(when)) {
				MediaTagDescVo whenTag = tagSearchInfo.get(when);
				vo.setWhenTagInfo(whenTag);
			}

			String why = vo.getWhyTagId();
			if (tagSearchInfo.containsKey(why)) {
				MediaTagDescVo whyTag = tagSearchInfo.get(why);
				vo.setWhyTagInfo(whyTag);
			}

			String how = vo.getHowTagId();
			if (tagSearchInfo.containsKey(how)) {
				MediaTagDescVo howTag = tagSearchInfo.get(how);
				vo.setHowTagInfo(howTag);
			}
		}

		res.setShotInfo(shotInfo);
		return res;
	}

	@Override
	public List<MediaCategoryVo> selectCategoryInfo() {
		return mediaDao.selectCategoryInfo();
	}

	@Override
	public int insertMediaCategory(MediaCategoryVo vo) throws Exception {
		return mediaDao.insertMediaCategory(vo);
	}

	@Override
	public int updateMediaCategory(MediaCategoryVo vo) throws Exception {
		MediaVo beforeMediaVo = mediaDao.selectMediaInfo(vo.getMediaId());
		beforeMediaVo.setCategory(vo.getCatId());

		String localFileLoc = beforeMediaVo.getLocalFile();
		String ext = ".mp4";
		if (localFileLoc.lastIndexOf(".") != -1) {
			ext = localFileLoc.substring(localFileLoc.lastIndexOf("."));
		}

		File localFileDir = new File(mediaUploadPath, localFileLoc).getParentFile();
		String categoryName = vo.getCatName();
		String dbInsertPath = mediaDbInsertPath + "/" + categoryName + "/" + vo.getMediaId() + "/";
		beforeMediaVo.setLocalFile(dbInsertPath + beforeMediaVo.getMediaId() + ext);
		beforeMediaVo.setThumbNail(dbInsertPath + beforeMediaVo.getMediaId() + ".png");

		File targetPath = new File(mediaUploadPath, "/uploads/" + categoryName + "/" + vo.getMediaId());
		try {
			FileUtils.moveDirectory(localFileDir, targetPath);
		} catch (Exception e) {
			logger.error(e.getMessage(), e);
			throw e;
		}

		List<MediaShotVo> shotVos = mediaDao.selectShotMediaActivity(vo.getMediaId());

		for (MediaShotVo shotVo : shotVos) {
			String startInfo = shotVo.getStartThumb();
			String endInfo = shotVo.getEndThumb();
			File sf = new File(startInfo);
			File ef = new File(endInfo);
			shotVo.setStartThumb(dbInsertPath + sf.getName());
			shotVo.setEndThumb(dbInsertPath + ef.getName());
			mediaDao.updateMediaShotThumb(shotVo);
		}

		return mediaDao.updateMediaCategory(beforeMediaVo);
	}

	@Override
	public int getShotId(int mediaId) {
		return mediaDao.getShotId(mediaId);
	}

	@Override
	public int deleteMedia(MediaVo vo) {
		int res = 0;
		for (int mediaId : vo.getSelectMediaId()) {
			try {
				MediaVo deleteTMedia = mediaDao.selectMediaInfo(mediaId);
				String thumbNail = deleteTMedia.getLocalFile();
				File tf = new File(thumbNail);
				File parent = tf.getParentFile();
				if (parent.exists()) {
					parent.delete();
				}
				res += mediaDao.deleteMedia(mediaId);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return res;
	}

	@Override
	public MediaShotVo insertMediaShot(MediaShotVo vo) throws Exception {
		String json = makeShotInfo(vo);

		Map<String, Object> map = new Gson().fromJson(json, Map.class);
		Map<String, Object> subStartObjec = (Map<String, Object>) map.get("shotStartInfo");
		Map<String, Object> subEndObjec = (Map<String, Object>) map.get("shotEndInfo");
		vo.setStartFrame(((Double) subStartObjec.get("frameNo")).intValue());
		vo.setEndFrame(((Double) subEndObjec.get("frameNo")).intValue());

		Map<String, String> startThumbNail = (Map<String, String>) subStartObjec.get("thumbnailPath");
		vo.setStartThumb(startThumbNail.get("url"));
		Map<String, String> endThumbNail = (Map<String, String>) subEndObjec.get("thumbnailPath");
		vo.setEndThumb(endThumbNail.get("url"));

		vo.setShotId(getShotId(vo.getMediaId()));
		try {
			mediaDao.insertMediaShot(vo);
			mediaDao.insertMediaActivity(vo);
		} catch (Exception e) {
			throw e;
		}
		return vo;
	}

	private String makeShotInfo(MediaShotVo vo) {
		URL u = null;
		HttpURLConnection conn = null;
		try {
			u = new URL(videoMakeShotUrl);
			conn = (HttpURLConnection) u.openConnection();
			conn.setDoOutput(true);
			conn.setRequestProperty("Content-Type", "application/json");
			JsonObject obj = new JsonObject();
			obj.addProperty("input", mediaUploadPath + vo.getLocalFile());
			obj.addProperty("insertUrl", vo.getLocalFile());
			obj.addProperty("startTime", vo.getStartTime());
			obj.addProperty("endTime", vo.getEndTime());
			obj.addProperty("startTimeCode", vo.getStartTimeCode());
			obj.addProperty("endTimeCode", vo.getEndTimeCode());

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
				while ((line = br.readLine()) != null) {
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

	@Override
	public int deleteMediaShot(MediaShotVo vo) throws Exception {
		// TODO Auto-generated method stub
		String startThumb = vo.getStartThumb();
		String endThumb = vo.getEndThumb();

		File sf = new File(mediaUploadPath, startThumb);
		if (sf.exists()) {
			sf.delete();
		}
		File ef = new File(mediaUploadPath, endThumb);
		if (ef.exists()) {
			ef.delete();
		}

		return mediaDao.deleteMediaShot(vo);
	}

	@Override
	public int editMediaTag(MediaTagDescVo vo) throws Exception {
		if (vo.getTagId() == 0) {
			return mediaDao.insertMediaTagDesc(vo);
		} else {
			return mediaDao.updateMediaTagDesc(vo);
		}
	}

	@Override
	public int updateActivity(MediaShotVo vo) throws Exception {
		return mediaDao.updateMediaActivity(vo);
	}

}
