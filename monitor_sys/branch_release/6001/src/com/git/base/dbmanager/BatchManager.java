package com.git.base.dbmanager;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import org.apache.commons.beanutils.ResultSetDynaClass;
import org.apache.commons.beanutils.ResultSetIterator;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

public class BatchManager {
	private BatchManager() {
	}

	public static BatchManager getInstance() {
		return new BatchManager();
	}

	private static final Log log = LogFactory.getLog(BatchManager.class);

	private Connection conn = null;

	private PreparedStatement ps = null;

	private ResultSet rs = null;

	/**
	 * 
	 * @param sql
	 * @return
	 */
	public ResultSetIterator resultSetIterator(String sql) {
		try {
			conn = Manager.getInstance().getConnect();
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			ResultSetDynaClass rsdc = new ResultSetDynaClass(rs);
			return (ResultSetIterator) rsdc.iterator();
		} catch (Exception e) {
			log.error("", e);
		}
		return null;
	}

	/**
	 * 
	 *
	 */
	public void close() {
		try {
			if (rs != null) {
				rs.close();
				rs = null;
			}
		} catch (Exception e) {
			log.error("", e);
		}
		try {
			if (ps != null) {
				ps.close();
				ps = null;
			}
		} catch (Exception e) {
			log.error("", e);
		}
		try {
			if (conn != null) {
				conn.close();
				conn = null;
			}
		} catch (Exception e) {
			log.error("", e);
		}
	}

	/**
	 * δ�ֹ�������Դ����ʱ������Դ�ͷ�ʱ���ùر�
	 */
	public void finalize() {
		if (rs != null) {
			log.warn("δ�ֹ�����close��ִ���Զ����ùر���������");
		}
		close();
	}
}
