package org.jrc.springfortune.service.impl;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.Date;





import org.jrc.common.utils.DatetimeUtil;
import org.jrc.common.utils.Utils;
import org.jrc.springfortune.service.IFileService;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

@Service(value="fileService")
public class FileServiceImpl implements IFileService {
	
	@Value(value="#{propertiesReader['annex_basepath']}")
	private String annexBasepath;

	public void saveFile(InputStream stream, String path,String fileName) throws IOException {
		String filePath = getFilePath(path);
		FileOutputStream fs = new FileOutputStream( filePath + "/"+ fileName);
        int byteread = 0; 
        byte[] buffer =new byte[1024*1024];
        while ((byteread=stream.read(buffer))!=-1)
        {
           fs.write(buffer,0,byteread);
           fs.flush();
        } 
        if(fs!=null){
        	fs.close();
		}
		if(stream!=null){
			stream.close();
		}
	}
	
	public void saveFile(byte[] fileContent, String path,String fileName) throws IOException {
		String filePath = getFilePath(path);
		FileOutputStream fs = new FileOutputStream( filePath + "/"+ fileName);
		fs.write(fileContent);
        fs.flush();
        if(fs!=null){
        	fs.close();
		}
	}

	public String getDefaultPath() {
		return DatetimeUtil.convertDateToString("yyyy/MM/dd/HHmmss", new Date());
	}

	public String getGenerateFilename(String originalFileName) {
		String filename = DatetimeUtil.convertDateToString("yyyyMMddHHmmss", new Date())+Utils.randomAlphanumeric(5);
		originalFileName = Utils.trim(originalFileName);
		if(originalFileName.lastIndexOf(".")>0){
			filename = filename + "." + originalFileName.substring(originalFileName.lastIndexOf(".")+1);
		}
		return filename;
	}

	public String getFilePath(String path){
		String filePath = annexBasepath + "/" + path;
		File file = new File(filePath);
		if(!file.exists()){
			file.mkdirs();
		}
		return filePath;
	}

	@Override
	public void delLocalFile(String filePath) {
		
		String absoultPath = annexBasepath + "/" + filePath ;
		File file = new File(absoultPath);
		if (!file.isDirectory()) {
			file.delete();
		}
	}
	
	
	
	

}
