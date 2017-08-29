package org.jrc.springfortune.controller;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.jrc.common.utils.JSONUtil;
import org.jrc.springfortune.service.IFileService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

@Controller
public class UploadController extends BaseController {
	
	@Value(value="#{propertiesReader['annex_basepath']}")
	private String annexBasepath;
	
	@Value(value="#{propertiesReader['annex_iconfile']}")
	private String annexIconfile;
	@Autowired
	private IFileService fileService;
	

	@RequestMapping("/user/upload.htm")
	public String uploadHandler(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws ServletException {
		return "upload/upload";
	}
	
	/**
	 * 附件上传处理。
	 * @param request
	 * @param response
	 * @param model
	 * @throws ServletException
	 * @throws IOException
	 */
	@RequestMapping("/user/upload_files.htm")
	public void uploadFilesHandler(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws ServletException, IOException {
		setBaseInfo(model);
		Map<String, String> map = new HashMap<String, String>();
		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest)request;
		MultipartFile file = multipartRequest.getFile("Filedata");
		
		if (!file.isEmpty()) {
			String originalFileName = file.getOriginalFilename();
			String path = fileService.getDefaultPath();
			String fileName = fileService.getGenerateFilename(originalFileName);
				
			fileService.saveFile(file.getBytes(), path, fileName);
			map.put("filePath", path + "/" + fileName);
			map.put("fileName", originalFileName);
		}
		
		String json = JSONUtil.map2json(map);
		response.getWriter().write(json);
		
	}
	
	/**
	 * 图片上传处理
	 * @param request
	 * @param response
	 * @param model
	 * @throws ServletException
	 * @throws IOException
	 */
	@RequestMapping("/user/upload_images.htm")
	public void uploadImageNewHandler(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws ServletException, IOException {
		setBaseInfo(model);
		
		Map<String, Object> map = new HashMap<String, Object>();
		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest)request;
		MultipartFile imgFile = multipartRequest.getFile("Filedata");
		if (!imgFile.isEmpty()) {
			String originalFileName = imgFile.getOriginalFilename();
			String path = fileService.getDefaultPath();
			String fileName = fileService.getGenerateFilename(originalFileName);
				
			fileService.saveFile(imgFile.getBytes(), path, fileName);
			
			map.put("filePath", path + "/" + fileName);
		}
        String json = JSONUtil.map2json(map);
        response.setContentType("text/html; charset=UTF-8");
        response.getWriter().write(json);
	}
	
	@RequestMapping("/user/local_file_del.htm")
	public void localFileDelHandler(HttpServletRequest request, HttpServletResponse response) 
	{
		
		String filePath = getParameter(request, "filePath");
		fileService.delLocalFile(filePath);
		
	}
	
	
}
