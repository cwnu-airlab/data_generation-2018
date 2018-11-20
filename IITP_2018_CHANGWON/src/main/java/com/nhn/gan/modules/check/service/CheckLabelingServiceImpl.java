package com.nhn.gan.modules.check.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.nhn.gan.common.utils.JsTree;
import com.nhn.gan.domain.CommonVo;
import com.nhn.gan.domain.EntityVo;
import com.nhn.gan.domain.RelationVo;
import com.nhn.gan.modules.brat.service.BratService;
import com.nhn.gan.modules.data.service.EntityService;

@Service("checkLabelingService")
public class CheckLabelingServiceImpl implements CheckLabelingService{
    
	@Value("#{app['brat.dataPath']}") private String dataLocation;
	
	@Autowired 
	public BratService bratService;	
	
	@Autowired
	public CheckEntityService checkEntityService;
	
	@Autowired
	public CheckRelationService checkRelationService;
	
	@Autowired 
	public EntityService entityService;
	
	public String elementJstreeHtml(String groupName, String[] selectIds) throws Exception {
		CommonVo commonVo = new CommonVo();
		commonVo.setGroupName(groupName);
		
		List<CommonVo> elementList = new ArrayList<CommonVo>();
		
		List<EntityVo> entityList = checkEntityService.getEntityList(commonVo);
		List<RelationVo> relationList = checkRelationService.getRelationList(commonVo);
		
		if (!entityList.isEmpty()) {
			HashMap<String,String> map = new HashMap<String,String>();
			
			for (EntityVo vo :entityList) {
				map.put(vo.getName(),vo.getJstreeName());
			}
			
			for (EntityVo vo :entityList) {
				commonVo = new CommonVo();
				String name = "객체/";
				commonVo.setJstreeId(vo.getName());
				
				if (!StringUtils.isEmpty(vo.getParentEnt())) {
					ArrayList<String> parentEntList = new ArrayList<String>();
					String parentEnt = vo.getParentEnt();
					parentEntList.add(parentEnt);
					
					while(true){
						EntityVo ent = new EntityVo();
						ent.setName(parentEnt);
						ent.setGroupName(vo.getGroupName());
						ent = entityService.getEntityOne(ent);
						if (ent != null) {
							if (!StringUtils.isEmpty(ent.getParentEnt())) {
								parentEnt = ent.getParentEnt();
								parentEntList.add(parentEnt);
								continue;
							} else {
								break;
							}
						}
						break;
					}
					for (int i=parentEntList.size()-1; i>=0; i--) {
						name += map.get(parentEntList.get(i));
						name += "/";
					}
				}
			
				name += vo.getJstreeName();
				commonVo.setJstreeName(name);
				elementList.add(commonVo);
			}
		}
		
		if (!relationList.isEmpty()) {
			HashMap<String,String> map = new HashMap<String,String>();
			
			for (RelationVo vo :relationList) {
				map.put(vo.getName(),vo.getJstreeName());
			}
			
			for (RelationVo vo :relationList) {
				commonVo = new CommonVo();
				String name = "관계/";
				commonVo.setJstreeId(vo.getName());
				//commonVo.setJstreeId("rel"+String.valueOf(vo.getRelId()));
				
				if (!StringUtils.isEmpty(vo.getParentRel())) {
					String parentRel[] = (vo.getParentRel()).split("/");
					for (int i=0; i<parentRel.length; i++) {
						name += map.get(parentRel[i]);
						name += "/";
					}
				}
				name += vo.getJstreeName();
				commonVo.setJstreeName(name);
				elementList.add(commonVo);
			}
		}
		return new JsTree.Mapper("jstreeId","jstreeName").parseAsHtml(elementList,selectIds);
	}
	
	
	public String getIndextSubstring(String str, String index) {
		int idx = str.lastIndexOf(index);
		if (idx > 0) {
			str = str.substring(0, idx);
		}
		return str;
	}
}
