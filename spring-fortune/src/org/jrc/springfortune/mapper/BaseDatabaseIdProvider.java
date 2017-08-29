package org.jrc.springfortune.mapper;

import java.sql.SQLException;
import java.util.Properties;

import javax.sql.DataSource;

import org.apache.ibatis.mapping.DatabaseIdProvider;

public class BaseDatabaseIdProvider implements DatabaseIdProvider {
	
	private Properties properties;
	
	private String dbDialect;

	public void setDbDialect(String dbDialect) {
		this.dbDialect = dbDialect;
	}

	public String getDatabaseId(DataSource dataSource) throws SQLException {
		return dbDialect;
	}

	public void setProperties(Properties properties) {
		this.properties = properties;
	}

}
