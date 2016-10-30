package com.guloulou.tools;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

public class HtmlDealwith {
	
	public HtmlDealwith() {

	}
	public HtmlDealwith(String url) {
		this.setUrlString(url);
	}
	private String urlString = "http://www.guloulou.com";

	public static HtmlDealwith getInstance(String url) {
		return new HtmlDealwith(url);
	}

	public String getHtml() {
		// String urlString = "http://10.5.5.94:7001/check.jsp";
		System.out.println(urlString);
		try {
			StringBuffer html = new StringBuffer();
			URL url = new URL(urlString);
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			InputStreamReader isrTmp = new InputStreamReader(conn.getInputStream());
			BufferedReader brTmp = new BufferedReader(isrTmp);
			String temp;
			while ((temp = brTmp.readLine()) != null) {
				html.append(temp).append("\n");
			}
			brTmp.close();
			isrTmp.close();
			return html.toString();
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}

	}
	
	public static void main(String [] args){
		
	String url = "http://10.5.5.94:7001/check.jsp";
		System.out.println(HtmlDealwith.getInstance(url).getHtml());
		
	}

	public String getUrlString() {
		return urlString;
	}

	public void setUrlString(String urlString) {
		this.urlString = urlString;
	}
}
