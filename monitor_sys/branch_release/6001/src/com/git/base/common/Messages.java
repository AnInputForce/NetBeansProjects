package com.git.base.common;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

public class Messages {
	private Map msgs = new HashMap();

	public Messages() {
	}

	/**
	 * 添加新的提示信息,参考 struts 的 ActionMessages
	 * 
	 * @param key
	 * @param msg
	 */
	public void addMsg(String key, Message msg) {
		List msgList = (List) msgs.get(key);
		if (msgList == null) {
			msgList = new ArrayList();
			msgs.put(key, msgList);
		}
		msgList.add(msg);
	}

	/**
	 * 合并消息列表
	 * 
	 * @param msgs
	 */
	public void addMsgs(Messages msgs) {
		if (msgs == null) {
			return;
		}
		this.msgs.putAll(msgs.getMsgMap());
	}

	/**
	 * 获取所有的提示信息
	 * 
	 * @return
	 */
	public List getMsgs() {
		if (msgs.isEmpty()) {
			return new ArrayList();
		}
		Iterator msgList = msgs.values().iterator();
		List l = new ArrayList();
		while (msgList.hasNext()) {
			l.addAll((List) msgList.next());
		}
		return l;
	}

	/**
	 * 获取key值对应的提示信息
	 * 
	 * @param key
	 * @return
	 */
	public List getMsgs(String key) {
		List msgList = (List) msgs.get(key);
		if (msgList == null) {
			msgList = new ArrayList();
		}
		return msgList;
	}

	/**
	 * 是否有提示信息
	 * 
	 * @return
	 */
	public boolean isEmpty() {
		return msgs == null ? true : msgs.isEmpty();
	}

	/**
	 * 信息数量
	 * 
	 * @return
	 */
	public int size() {
		return msgs == null ? 0 : msgs.size();
	}

	/**
	 * 获取消息对应 map
	 * 
	 * @return
	 */
	protected Map getMsgMap() {
		return msgs;
	}
}
