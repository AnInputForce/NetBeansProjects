package com.guloulou.test;

import java.io.*;

public class OP_File {
	public BufferedReader bufread;

	public BufferedWriter bufwriter;

	File writefile;

	String filepath, filecontent, read;

	String readStr = "";

	public String readfile(String path) // 从文本文件中读取内容
	{
		try {
			filepath = path; // 得到文本文件的路径
			File file = new File(filepath);
			FileReader fileread = new FileReader(file);
			bufread = new BufferedReader(fileread);
			while ((read = bufread.readLine()) != null) {
				readStr = readStr + read;
			}
		} catch (Exception d) {
			System.out.println(d.getMessage());
		}
		return readStr; // 返回从文本文件中读取内容
	}
}
