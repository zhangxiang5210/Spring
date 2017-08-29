package org.jrc.springfortune.entity;



import java.util.Date;


/**
 * 
 * @author johnny.Lu
 * @version 1.0
 * @date Jun 18, 2007
 */
public class Annex {

	private Long id;
	
	private Long annexCategorycode;
	
	private Long objId;
	
	private String filePath;
	
	private String fileName;
	
	private Long fileSize;
	
	private String fileType;
	
	private Date createTime;
	
	private String creator;
	
	public Long getId() {
		return this.id;
	}

	public void setId(Long id) {
		this.id = id;
	}
	
	public Long getAnnexCategorycode() {
		return this.annexCategorycode;
	}

	public void setAnnexCategorycode(Long annexCategorycode) {
		this.annexCategorycode = annexCategorycode;
	}
	
	public Long getObjId() {
		return this.objId;
	}

	public void setObjId(Long objId) {
		this.objId = objId;
	}
	
	public String getFilePath() {
		return this.filePath;
	}

	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}
	
	public String getFileName() {
		return this.fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	
	public Long getFileSize() {
		return this.fileSize;
	}

	public void setFileSize(Long fileSize) {
		this.fileSize = fileSize;
	}
	
	public String getFileType() {
		return this.fileType;
	}

	public void setFileType(String fileType) {
		this.fileType = fileType;
	}
	
	public Date getCreateTime() {
		return this.createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
	
	public String getCreator() {
		return this.creator;
	}

	public void setCreator(String creator) {
		this.creator = creator;
	}
	
}
