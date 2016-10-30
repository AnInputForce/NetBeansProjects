package com.guloulou.bean;

import java.util.ArrayList;
import java.util.List;

public class GroupServer {

	private int groupnum = 3;

	private List list = new ArrayList();

	public GroupServer() {

	}

	public static GroupServer getInstance() {
		return new GroupServer();
	}

	public int getGroupnum() {
		return groupnum;
	}

	public void setGroupnum(int groupnum) {
		this.groupnum = groupnum;
	}

	public List getList() {
		return list;
	}

	public void setList(List list) {
		this.list = list;
	}

}
