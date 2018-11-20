package com.nhn.gan.modules.auto.service;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.nhn.gan.domain.DocumentVo;
import com.nhn.gan.domain.HistoryVo;
import com.nhn.gan.modules.auto.dao.AutoLabelingDao;
import com.nhn.gan.modules.data.service.DocumentService;

@Service("autoLabelingService")
public class AutoLabelingServiceImpl implements AutoLabelingService{
	
	@Autowired
	public DocumentService documentService;
	
	@Autowired 
	public AutoLabelingDao autoLabelingDao;	
	
	public void labelingStart(DocumentVo vo) throws Exception {
		String[] docIds = vo.getDocIds();
		DocumentVo doc;
		DocumentVo record;
		
		for (int i=0; i<docIds.length; i++) {
			doc = new DocumentVo();
			record = new DocumentVo();
			
			doc.setDocId(Integer.parseInt(docIds[i]));
			doc.setGroupName(vo.getLabelingGroupName());
			doc.setUserId(vo.getUserId());
			
			record = documentService.getRecordOne(doc);
			int recordId;
			int recordSeq = 0;
			int docId =  Integer.parseInt(docIds[i]);
			
			if (record == null) {
				doc.setRabelStat("자동");
				recordId = documentService.insertRecord(doc);
			} else { 
				recordId = record.getRecordId();
			}
			
			AutoLabelProcess autoLabelProcess = new AutoLabelProcess(recordId, recordSeq, docId);
			autoLabelProcess.startup();
		}
	}
	
	public List<DocumentVo> getAutoLabelingList(DocumentVo vo) throws Exception {
		List<DocumentVo> list = documentService.getDocRecordList(vo);
		List<HistoryVo> jobList = new ArrayList<>();
		int index = 0; 
		
		for (DocumentVo doc : list) {
			jobList = new ArrayList<>();
			jobList = autoLabelingDao.getAutoLabelingStat(doc);
			
			if (!jobList.isEmpty()) {
				doc.setStartDate("");
				doc.setEndDate("");
				
				for (HistoryVo job : jobList) {
					String type = job.getJob();
					if (StringUtils.equals(type, "시작")) {
						doc.setRegId(job.getRegId());
						doc.setStartDate(new SimpleDateFormat("yyyy-MM-dd").format(job.getRegDate()));
					}
					if (StringUtils.equals(type, "종료")) {
						doc.setEndDate(new SimpleDateFormat("yyyy-MM-dd").format(job.getRegDate()));
					}
				}
			}
			
			list.set(index, doc);
			index++;
		}
		return list;
	}

	public int getAutoLabelingListCount(DocumentVo vo) throws Exception {
		return documentService.getDocRecordListCount(vo);
	}
}
