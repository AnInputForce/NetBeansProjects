package com.git.base.common;
import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

public class MakeJrxmlFile {
	
	public static final String suffix=".bak";
	private static final String path="conf/";
	public static final String realPath = MakeJrxmlFile.class.getClassLoader().getResource(path).getPath()+"/../../report/tempFile/";
	
	

	
	public static void makeFile(List dataList,String fileName){
		
		File fileResult  = new File(realPath+fileName+suffix);
		
		
		BufferedWriter write =null;
		try {
			if(fileResult.exists()){
				fileResult.delete();
			}
			
			fileResult.createNewFile();
			write = new BufferedWriter(new FileWriter(fileResult));
			
			Map dataMap = (Map) dataList.get(0);
			System.out.println("dataMap.size()------"+dataMap.size());
			Iterator it = dataMap.keySet().iterator();
			
			
			
			while(it.hasNext()){
				String key = (String) it.next();
				
				String  value ="¡¡";
				if(dataMap.get(key)!=null){
					value =dataMap.get(key).toString();
				};

				write.write(key+","+value+"\n");
				
			}
			
			
		} catch (IOException e) {
		
			e.printStackTrace();
		}finally{
			try {
				if(write!=null){
					write.close();
				}
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		
		
		
		
	}
	
	public static List getFileValue(String fileName,String regex){
		
		File fileResult  = new File(realPath+fileName+suffix);
		List list = new ArrayList();
		
		if(!fileResult.exists()){
			return list;
		}
		BufferedReader read =null;
		try {
			
			read = new BufferedReader(new FileReader(fileResult));
			
			
			Map dataMap = new LinkedHashMap();
			while(true){
				String value = read.readLine();
				if(value==null||value.trim().equals("")){
					break;
				}
				System.out.println(value);
				
				String tmp[] = value.split(regex);
				if(tmp.length>1){
					dataMap.put(tmp[0], tmp[1]);
				}
				
				
				
			}
			list.add(dataMap);

		} catch (IOException e) {
		
			e.printStackTrace();
		}finally{
			try {
				if(read!=null){
					read.close();
				}
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		
		return list;
		
		
		
	}
	
	
	

	
}