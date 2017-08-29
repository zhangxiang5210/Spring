package org.jrc.springfortune.service;

import java.io.IOException;
import java.io.InputStream;

public interface IFileService {
	
	/**
	 * 保存文件
	 * @param stream
	 * @param filePath
	 * @throws IOException 
	 */
	public void saveFile(InputStream stream,String path,String fileName) throws IOException;
	
	/**
	 * 保存文件
	 * @param stream
	 * @param filePath
	 * @throws IOException 
	 */
	public void saveFile(byte[] fileContent,String path,String fileName) throws IOException;
	
	/**
	 * 获取默认路径
	 * @return
	 */
	public String getDefaultPath();
	
	/**
	 * 获取默认文件名
	 * @return
	 */
	public String getGenerateFilename(String originalFileName);
	
	/**
	 * 获取文件路径
	 * @param path
	 * @return
	 */
	public String getFilePath(String path);
	
	/**
	 * 删除本地文件
	 * @param filePath
	 */
	public void delLocalFile(String filePath);

}
