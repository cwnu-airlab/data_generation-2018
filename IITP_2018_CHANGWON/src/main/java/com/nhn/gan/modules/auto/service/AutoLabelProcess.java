package com.nhn.gan.modules.auto.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;

import com.diquest.labelproj.api.Labeler;
import com.nhn.gan.domain.DocumentVo;
import com.nhn.gan.modules.data.service.DocumentService;

public class AutoLabelProcess implements Runnable {
	
	@Autowired
	public DocumentService documentService;
	
	Logger log = LoggerFactory.getLogger(this.getClass());
	private int recordId;
	private int recordSeq;
	private int docId;
	private Thread thread;
	
	public AutoLabelProcess(int recordId, int recordSeq, int docId) {
		this.recordId = recordId;
		this.recordSeq = recordSeq;
		this.docId = docId;
	}
		
	public void startup() {
		this.thread = new Thread(this);
		this.thread.start();
	}

	@Override
	public void run() {
		try {
			log.info("자동레이블링 시작");
			log.info("RECORD_ID: "+this.recordId+", RECORD_SEQ: "+recordSeq+", DOC_ID: "+docId);
			Labeler.getInstance(recordId,recordSeq, docId, "donga").label();
			log.info("자동레이블링 정상 종료");
			log.info("RECORD_ID: "+this.recordId+", RECORD_SEQ: "+recordSeq+", DOC_ID: "+docId);
		} catch (Exception e) {
			try {
				DocumentVo vo = new DocumentVo();
				vo.setRecordId(this.recordId);
				vo.setRabelStat("실패");
				documentService.updateRabelStat(vo);
				
				log.error("자동레이블링 비정상 종료",e);
				log.info("RECORD_ID: "+this.recordId+", RECORD_SEQ: "+recordSeq+", DOC_ID: "+docId);
			} catch (Exception e1) {
				e1.printStackTrace();
			}
		}
	}

}
