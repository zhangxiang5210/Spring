package org.jrc.common.utils;

import java.beans.IntrospectionException;
import java.beans.Introspector;
import java.beans.PropertyDescriptor;
import java.math.BigDecimal;
import java.math.BigInteger;
import java.sql.Date;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

public class JSONUtil {
	private static Log log = LogFactory.getLog(JSONUtil.class);

	public static String object2json(Object obj) {
		StringBuilder json = new StringBuilder();
		try{
			if (obj == null) {
				json.append("\"\"");
			} else if (obj instanceof String || obj instanceof Integer
					|| obj instanceof Float || obj instanceof Date
					|| obj instanceof Short || obj instanceof Double
					|| obj instanceof Long || obj instanceof BigDecimal
					|| obj instanceof BigInteger || obj instanceof Byte) {
				json.append("\"").append(string2json(obj.toString())).append("\"");
			} else if (obj instanceof Boolean) {
				json.append(boolean2json((Boolean) obj));
			} else if (obj instanceof Object[]) {
				json.append(array2json((Object[]) obj));
			} else if (obj instanceof List) {
				json.append(list2json((List<?>) obj));
			} else if (obj instanceof Map) {
				json.append(map2json((Map<?, ?>) obj));
			} else if (obj instanceof Set) {
				json.append(set2json((Set<?>) obj));
			} else {
				json.append(bean2json(obj));
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return json.toString();
	}

	public static String bean2json(Object bean) {
		StringBuilder json = new StringBuilder();
		json.append("{");
		PropertyDescriptor[] props = null;
		try {
			props = Introspector.getBeanInfo(bean.getClass(), Object.class)
					.getPropertyDescriptors();
		} catch (IntrospectionException e) {
		}
		if (props != null) {
			for (int i = 0; i < props.length; i++) {
				try {
					String name = object2json(props[i].getName());
					String value = object2json(props[i].getReadMethod().invoke(
							bean));
					json.append(name);
					json.append(":");
					json.append(value);
					json.append(",");
				} catch (Exception e) {
				}
			}
			json.setCharAt(json.length() - 1, '}');
		} else {
			json.append("}");
		}
		return json.toString();
	}

	public static String list2json(List<?> list) {
		StringBuilder json = new StringBuilder();
		json.append("[");
		if (list != null && list.size() > 0) {
			for (Object obj : list) {
				json.append(object2json(obj));
				json.append(",");
			}
			json.setCharAt(json.length() - 1, ']');
		} else {
			json.append("]");
		}
		return json.toString();
	}
	
	public static String boolean2json(Boolean obj){
		return obj.toString();
	}

	public static String array2json(Object[] array) {
		StringBuilder json = new StringBuilder();
		json.append("[");
		if (array != null && array.length > 0) {
			for (Object obj : array) {
				json.append(object2json(obj));
				json.append(",");
			}
			json.setCharAt(json.length() - 1, ']');
		} else {
			json.append("]");
		}
		return json.toString();
	}

	public static String map2json(Map<?, ?> map) {
		StringBuilder json = new StringBuilder();
		json.append("{");
		if (map != null && map.size() > 0) {
			for (Object key : map.keySet()) {
				json.append(object2json(key));
				json.append(":");
				json.append(object2json(map.get(key)));
				json.append(",");
			}
			json.setCharAt(json.length() - 1, '}');
		} else {
			json.append("}");
		}
		return json.toString();
	}

	public static String set2json(Set<?> set) {
		StringBuilder json = new StringBuilder();
		json.append("[");
		if (set != null && set.size() > 0) {
			for (Object obj : set) {
				json.append(object2json(obj));
				json.append(",");
			}
			json.setCharAt(json.length() - 1, ']');
		} else {
			json.append("]");
		}
		return json.toString();
	}

	public static String string2json(String s) {
		if (s == null)
			return "";
		StringBuilder sb = new StringBuilder();
		for (int i = 0; i < s.length(); i++) {
			char ch = s.charAt(i);
			switch (ch) {
			case '\'':
				sb.append("\\\'");
				break;
			case '"':
				sb.append("\\\"");
				break;
			case '\\':
				sb.append("\\\\");
				break;
			case '\b':
				sb.append("\\b");
				break;
			case '\f':
				sb.append("\\f");
				break;
			case '\n':
				sb.append("\\n");
				break;
			case '\r':
				sb.append("\\r");
				break;
			case '\t':
				sb.append("\\t");
				break;
			case '/':
				sb.append("\\/");
				break;
			default:
				if (ch >= '\u0000' && ch <= '\u001F') {
					String ss = Integer.toHexString(ch);
					sb.append("\\u");
					for (int k = 0; k < 4 - ss.length(); k++) {
						sb.append('0');
					}
					sb.append(ss.toUpperCase());
				} else {
					sb.append(ch);
				}
			}
		}
		return sb.toString();
	}
	
	public static List<Map<String, Object>> parseJSON2List(String jsonStr){
		if(jsonStr==null||"".equals(jsonStr)){
			return null;
		}
		
		List<Map<String, Object>> list = new ArrayList<Map<String,Object>>();
		try{
			JSONArray jsonArr = JSONArray.fromObject(jsonStr);
	        Iterator<JSONObject> it = jsonArr.iterator();
	        while(it.hasNext()){
	            JSONObject json2 = it.next();
	            list.add(parseJSON2Map(json2.toString()));
	        }
	        return list;
		}catch(Exception e){
			e.printStackTrace();
		}
        
        return null;
    }

	public static Map<String, Object> parseJSON2Map(String jsonStr){
		if(jsonStr==null||"".equals(jsonStr)){
			return null;
		}
        Map<String, Object> map = new HashMap<String, Object>();
        try{
        	 JSONObject json = JSONObject.fromObject(jsonStr);
             for(Object k : json.keySet()){
                 Object v = json.get(k); 
                 if(v instanceof JSONArray){
                     List<Map<String, Object>> list = new ArrayList<Map<String,Object>>();
                     Iterator<JSONObject> it = ((JSONArray)v).iterator();
                     while(it.hasNext()){
                         JSONObject json2 = it.next();
                         list.add(parseJSON2Map(json2.toString()));
                     }
                     map.put(k.toString(), list);
                 } else {
                     map.put(k.toString(), v);
                 }
             }
             return map;
        }catch(Exception e){
        	e.printStackTrace();
        }
        return null;   
    }

	
	public static void main(String[] args){
		String str = "{'flag':'1','recordList':[{'recordId':'81','tableName':'PUB_SECURITIESMAIN','dataCount':'3','packageTime':'2012-07-25 13:22:32','packageFilePath':'/PUB_SECURITIESMAIN/2012/7/25/81.zip','packageDate':'2012-07-25'}],'msg':'DPS-Download record success!'}";
		Map<String,Object> jsonMap = parseJSON2Map(str);
		List<Map<String, Object>> list = (List<Map<String, Object>>) jsonMap.get("recordList");
		System.out.println(jsonMap);
	}
	
}
