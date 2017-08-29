package org.jrc.springfortune.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.jrc.common.utils.JSONUtil;
import org.jrc.springfortune.constants.SpringFortuneConstans;
import org.jrc.springfortune.entity.Annex;
import org.jrc.springfortune.entity.ExecuteResult;
import org.jrc.springfortune.service.IAnnexService;
import org.jrc.springfortune.service.IFileService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class AnnexController extends BaseController
{
	@Autowired
	private IAnnexService annexService;
	@Autowired
	private IFileService fileService;
	
	
	@RequestMapping("/user/annex_delete.htm")
	public void annexDeleteHandler(HttpServletRequest request, HttpServletResponse response) throws IOException 
	{
		ExecuteResult result = new ExecuteResult();
		result.setSuccess(true);
		
		Map<String, Object> param = new HashMap<String, Object>();
		String id = getParameter(request, "id");
		param.put("id", id);
		
		
		try {
			Annex annex = annexService.get(param);
			String path = annex.getFilePath();
			annexService.delete(param);
			fileService.delLocalFile(path);
		} catch (Exception e) {
			log.info("删除文件发生异常",e);
			result.setSuccess(false);
			result.setMsg(SpringFortuneConstans.DEFAULT_ERROR_MSG);
		}
		
		String json = JSONUtil.bean2json(result);
		response.setContentType("text/html; charset=UTF-8");
		response.getWriter().write(json);
	}
}
