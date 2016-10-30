package com.git.base.common;

public class Message {
	public static int MSG_TYPE_SUCC = 0;

	public static int MSG_TYPE_WARN = 1;

	public static int MSG_TYPE_ERROR = 2;

	private int msgLevel = -1;

	private String msgStr = "";

	private Throwable exp = null;

	/**
	 * 从消息资源文件中获取 key 对应的消息 
	 * TODO：添加消息获取的处理
	 * @param msgLevel
	 * @param key
	 */
	public Message(int msgLevel, String key) {
		this.msgLevel = msgLevel;
		this.msgStr = keyToMessage(key);
	}

	/**
	 * 从消息资源文件中获取 key 对应的消息，并将 arg1 填充到第一个参数中 
	 * TODO：添加消息获取的处理
	 * @param msgLevel
	 * @param key
	 * @param arg1
	 */
	public Message(int msgLevel, String key, String arg1) {
		this.msgLevel = msgLevel;
		this.msgStr = keyToMessage(key);
	}

	/**
	 * 从消息资源文件中获取 key 对应的消息，并将 arg1 和 arg2 分别填充到对应的参数中 
	 * TODO：添加消息获取的处理
	 * @param msgLevel
	 * @param key
	 * @param arg1
	 * @param arg2
	 */
	public Message(int msgLevel, String key, String arg1, String arg2) {
		this.msgLevel = msgLevel;
		this.msgStr = keyToMessage(key);
	}

	/**
	 * 从消息资源文件获取 key 对应的消息 TODO：添加消息获取的处理
	 * 
	 * @param msgLevel
	 * @param key
	 * @param exp
	 */
	public Message(int msgLevel, String key, Throwable exp) {
		this.msgLevel = msgLevel;
		this.exp = exp;
		this.msgStr = keyToMessage(key);
	}

	public Message(int msgLevel, Throwable exp) {
		this.msgLevel = msgLevel;
		this.exp = exp;
	}

	public Message(Throwable exp) {
		this.msgLevel = MSG_TYPE_ERROR;
		this.exp = exp;
	}

	public int getMsgLevel() {
		return this.msgLevel;
	}

	public Throwable getExp() {
		return this.exp;
	}

	public String getMsgStr() {
		return this.msgStr;
	}

	public String toString() {
		return "cehck Result[" + msgLevel + "] msg[" + msgStr + "] expMsg[" + (exp == null ? "" : exp.getMessage()) + "]";
	}

	/**
	 * 
	 * @param key
	 * @return
	 */
	private String keyToMessage(String key) {
		return key;
	}
}
