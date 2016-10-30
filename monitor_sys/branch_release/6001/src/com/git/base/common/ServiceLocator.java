package com.git.base.common;

/**
 * <p>Title: </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2004</p>
 * <p>Company: </p>
 * @author not attributable
 * @version 1.0
 */
/***
 *
 */
import java.util.Collections;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;

import javax.ejb.EJBHome;
import javax.ejb.EJBLocalHome;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.rmi.PortableRemoteObject;
import javax.sql.DataSource;
import javax.transaction.UserTransaction;

import com.git.base.cfg.Service;
import com.git.base.exceptions.ServiceLocatorException;

public class ServiceLocator implements Locator {
	private InitialContext ic;

	private Map cache; // used to hold references to EJBHomes/JMS Resources for
						// re-use

	String url = Service.getHostUrl();

	// private static String url = null;
	private static String wlurl = null;

	private static String user = null;

	private static String password = null;

	private static Object lock = new Object();

	private static ServiceLocator serviceLocator = null;

	private ServiceLocator() throws ServiceLocatorException, Exception {
		try {
			if (url == null || url.equals("")) {
				ic = new InitialContext();
			} else {
				wlurl = url;
				if (Service.getAppServer().equals("weblogic")) {
					ic = (InitialContext) getWeblogicContext();

				} else if (Service.getAppServer().equals("jboss")) {
					ic = (InitialContext) getJBossContext();
				}
			}

			cache = Collections.synchronizedMap(new HashMap());
		} catch (NamingException ne) {
			throw new ServiceLocatorException(ne);
		} catch (Exception e) {
			throw new ServiceLocatorException(e);
		}

	}

	/***************************************************************************
	 * 
	 */
	public static ServiceLocator getInstance() throws ServiceLocatorException, Exception {
		if (serviceLocator == null) {
			synchronized (lock) {
				if (serviceLocator == null) {
					serviceLocator = new ServiceLocator();
				}
			}
		}
		return serviceLocator;
	}

	/**
	 * will get the ejb Local home factory. If this ejb home factory has already
	 * been clients need to cast to the type of EJBHome they desire
	 * 
	 * @return the EJB Home corresponding to the homeName
	 */
	public EJBLocalHome getLocalHome(String jndiHomeName) throws ServiceLocatorException {
		EJBLocalHome home = null;
		try {
			if (cache.containsKey(jndiHomeName)) {
				home = (EJBLocalHome) cache.get(jndiHomeName);
			} else {
				home = (EJBLocalHome) ic.lookup(jndiHomeName);
				cache.put(jndiHomeName, home);
			}
		} catch (NamingException ne) {
			throw new ServiceLocatorException(ne);
		} catch (Exception e) {
			throw new ServiceLocatorException(e);
		}
		return home;
	}

	/**
	 * will get the ejb Remote home factory. If this ejb home factory has
	 * already been clients need to cast to the type of EJBHome they desire
	 * 
	 * @return the EJB Home corresponding to the homeName
	 */
	public EJBHome getRemoteHome(String jndiHomeName, Class className) throws ServiceLocatorException {
		EJBHome home = null;
		try {
			if (cache.containsKey(jndiHomeName)) {
				home = (EJBHome) cache.get(jndiHomeName);
			} else {
				Object objref = ic.lookup(jndiHomeName);
				Object obj = PortableRemoteObject.narrow(objref, className);
				home = (EJBHome) obj;
				cache.put(jndiHomeName, home);
			}
		} catch (NamingException ne) {
			throw new ServiceLocatorException(ne);
			// System.out.println(ne.getMessage());
		} catch (Exception e) {
			throw new ServiceLocatorException(e);
		}

		return home;
	}

	/**
	 * @return the DataSource
	 */
	public DataSource getDataSource(String datastr) throws ServiceLocatorException {
		DataSource datas;
		try {
			if (cache.containsKey(datastr)) {
				datas = (DataSource) cache.get(datastr);
			} else {
				datas = (DataSource) ic.lookup(datastr);
				cache.put(datastr, datas);
			}
		} catch (NamingException ne) {
			throw new ServiceLocatorException(ne);
		} catch (Exception e) {
			throw new ServiceLocatorException(e);
		}
		return datas;
	}

	// //get user transaction
	// public javax.transaction.UserTransaction getUsTranstion()throws
	// ServiceLocatorException{
	// UserTransaction ust;
	// synchronized(lock){
	// try {
	// ust = (UserTransaction) ic.lookup("java:comp/UserTransaction");
	// } catch (Exception e) {
	// throw new ServiceLocatorException(e);
	// }
	// }
	// return ust;
	// }
	/***************************************************************************
	 * 初始化一个普通的上下文，并创建一个hashmap实例作为对相关对象的缓冲。
	 */
	public Context getInitialContext() throws ServiceLocatorException {
		try {
			cache = Collections.synchronizedMap(new HashMap());
			return new InitialContext();
		} catch (NamingException e) {
			throw new ServiceLocatorException(e.getMessage());
		}
	}

	public static void setWeblogicContext(String url, String user, String pasw) {
		wlurl = url;
		ServiceLocator.user = user;
		password = pasw;
	}

	/***************************************************************************
	 * 
	 */
	public Context getWeblogicContext() throws Exception {
		Properties properties = null;
		try {
			properties = new Properties();
			properties.put(Context.INITIAL_CONTEXT_FACTORY, "weblogic.jndi.WLInitialContextFactory");
			properties.put(Context.PROVIDER_URL, wlurl);
			if (user != null) {
				properties.put(Context.SECURITY_PRINCIPAL, user);
				properties.put(Context.SECURITY_CREDENTIALS, password == null ? "" : password);
			}
			return new InitialContext(properties);
		} catch (Exception e) {
			System.out.println("Unable to connect to WebLogic server at " + url);
			System.out.println("Please make sure that the server is running.");
			throw e;
		}
	}

	/**
	 * 获得jboss的context
	 * 
	 * @return
	 * @throws java.lang.Exception
	 */
	public Context getJBossContext() throws Exception {
		Properties properties = null;
		try {
			properties = new Properties();
			properties.put(Context.INITIAL_CONTEXT_FACTORY, "org.jnp.interfaces.NamingContextFactory");
			// properties.put(Context.URL_PKG_PREFIXES,
			// "jboss.naming:org.jnp.interfaces");
			properties.put(Context.PROVIDER_URL, url);

			cache = Collections.synchronizedMap(new HashMap());
			return new InitialContext(properties);
		} catch (Exception e) {
			System.out.println("Unable to connect to Jboss server at " + url);
			System.out.println("Please make sure that the server is running.");
			throw e;
		}
	}

	public UserTransaction getTransaction() throws Exception {
		UserTransaction trans;
		String transName = "javax.transaction.UserTransaction";
		try {
			if (cache.containsKey(transName)) {
				trans = (UserTransaction) cache.get(transName);
			} else {
				trans = (UserTransaction) ic.lookup(transName);
				cache.put(transName, trans);
			}
		} catch (NamingException ne) {
			throw new ServiceLocatorException(ne);
		} catch (Exception e) {
			throw new ServiceLocatorException(e);
		}
		return trans;

	}

}