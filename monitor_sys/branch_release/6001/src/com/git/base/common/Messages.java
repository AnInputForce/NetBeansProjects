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
	 * ����µ���ʾ��Ϣ,�ο� struts �� ActionMessages
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
	 * �ϲ���Ϣ�б�
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
	 * ��ȡ���е���ʾ��Ϣ
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
	 * ��ȡkeyֵ��Ӧ����ʾ��Ϣ
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
	 * �Ƿ�����ʾ��Ϣ
	 * 
	 * @return
	 */
	public boolean isEmpty() {
		return msgs == null ? true : msgs.isEmpty();
	}

	/**
	 * ��Ϣ����
	 * 
	 * @return
	 */
	public int size() {
		return msgs == null ? 0 : msgs.size();
	}

	/**
	 * ��ȡ��Ϣ��Ӧ map
	 * 
	 * @return
	 */
	protected Map getMsgMap() {
		return msgs;
	}
}
