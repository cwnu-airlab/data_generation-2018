package com.nhn.gan.modules.learning.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;

import com.diquest.labelproj.api.TrainSetSaver;
import com.nhn.gan.domain.DocumentVo;
import com.nhn.gan.modules.data.service.DocumentService;

public class LearningProcess implements Runnable {
	
	@Autowired
	public DocumentService documentService;
	
	Logger log = LoggerFactory.getLogger(this.getClass());
	private int recordId;
	private int recordSeq;
	private Thread thread;
	
	public LearningProcess(int recordId, int recordSeq) {
		this.recordId = recordId;
		this.recordSeq = recordSeq;
	}
		
	public void startup() {
		this.thread = new Thread(this);
		this.thread.start();
	}

	@Override
	public void run() {
		try {
			log.info("학습데이터 생성 시작");
			log.info("RECORD_ID: "+this.recordId+", RECORD_SEQ: "+recordSeq);
			TrainSetSaver saver = new TrainSetSaver(recordId, recordSeq);
			saver.save();
			log.info("학습데이터 생성 정상 종료");
			log.info("RECORD_ID: "+this.recordId+", RECORD_SEQ: "+recordSeq);
		} catch (Exception e) {
			try {
				DocumentVo vo = new DocumentVo();
				vo.setRecordId(this.recordId);
				vo.setRabelStat("실패");
				documentService.updateLearnStat(vo);
				
				log.error("학습데이터 생성 비정상 종료",e);
				log.info("RECORD_ID: "+this.recordId+", RECORD_SEQ: "+recordSeq);
			} catch (Exception e1) {
				e1.printStackTrace();
			}
		}
	}

}
