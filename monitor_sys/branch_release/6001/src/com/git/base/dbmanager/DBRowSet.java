package com.git.base.dbmanager;

import java.io.Serializable;
import java.math.BigDecimal;
import java.sql.Date;
import java.sql.Timestamp;
import java.util.HashMap;
import java.util.List;

/**
 * PoolDBUtils取数据后，将数据存放在这个类中，用户不再需要操作复杂的jdbc
 * 
 * 
 * 
 */
public class DBRowSet implements Serializable {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private int rowCount = 0;

    private int columnCount = 0;

    private String[] columnNames = {};

    private int[] columnTypes = {};

    private List rows;

    private HashMap nameTypeMap = new HashMap(); // columnName -> columnType

    private HashMap nameColumnIndexMap = new HashMap(); // columnName -> column

    // index

    public DBRowSet(List rows, int columnCount, String[] columnNames, int[] columnTypes) {
        this.rowCount = rows.size();
        this.columnCount = columnCount;
        this.columnNames = columnNames;
        this.columnTypes = columnTypes;
        this.rows = rows;

        for (int i = 0; i < columnCount; i++) {
            nameTypeMap.put(columnNames[i], new Integer(columnTypes[i]));
            nameColumnIndexMap.put(columnNames[i], new Integer(i));
        }
    }

    /**
     * Get the count of rows.
     * 
     * @return The count of rows
     */
    public int getRowCount() {
        return this.rowCount;
    }

    /**
     * Get the count of columns.
     * 
     * @return The count of columns
     */
    public int getColumnCount() {
        return this.columnCount;
    }

    /**
     * Get the column names from sql.
     * 
     * @return The column names
     */
    public String[] getColumnNames() {
        return this.columnNames;
    }

    /**
     * Get the column sql type.
     * 
     * @return The column sql type(defined in java.sql.Types).
     */
    public int[] getColumnTypes() {
        return this.columnTypes;
    }

    /**
     * Get all data retrieved from database.
     * 
     * @return All data
     */
    public List getRows() {
        return this.rows;
    }

    /**
     * Get the column sql type according to the column name.
     * 
     * @param columnName
     *            column name.
     * @return The column sql type(defined in java.sql.Types).
     */
    public int getColumnType(String columnName) {
        Object obj = nameTypeMap.get(columnName);
        if (obj == null) {
            return -1;
        } else {
            return ((Integer) obj).intValue();
        }
    }

    /**
     * Get the data of the specified row.
     * 
     * @param row
     *            the row number(0-based)
     * @return The data of the specified row
     */
    public List getRow(int row) {
        return (List) this.rows.get(row);
    }

    /**
     * Get the data of the specified row and column.
     * 
     * @param row
     *            the row number(0-based)
     * @param column
     *            the column index(0-based)
     * @return The data of the specified row
     */
    public Object getValueAt(int row, int column) {
        return getRow(row).get(column);
    }

    /**
     * Get the data of the specified row and column.
     * 
     * @param row
     *            the row number(0-based)
     * @param column
     *            the column name
     * @return The data of the specified row column
     */
    public Object getValueAt(int row, String columnName) {
        List data = getRow(row);
        Object obj = nameColumnIndexMap.get(columnName);
        if (obj == null) {
            return null;
        } else {
            return data.get(((Integer) obj).intValue());
        }
    }

    /**
     * get a String value
     */
    public String getString(int row, int column) {
        Object ob = getValueAt(row, column);
        String s = ob == null ? null : ob.toString();
        return s;
        // return Utils.convertEncode(s, "utf8", "ISO-8859-1");
    }

    public String getString(int row, String columnName) {
        Object ob = getValueAt(row, columnName.toUpperCase());
        String s = ob == null ? null : ob.toString();
        return s;
        // return Utils.convertEncode(s, "utf8", "ISO-8859-1");
    }

    /**
     * get a int value
     */
    public int getInt(int row, int column) {
        Object ob = getValueAt(row, column);
        return ob == null ? 0 : (new BigDecimal(ob.toString())).intValue();
    }

    public int getInt(int row, String columnName) {
        Object ob = getValueAt(row, columnName);
        return ob == null ? 0 : (new BigDecimal(ob.toString())).intValue();
    }

    /**
     * get a long value
     */
    public long getLong(int row, int column) {
        Object ob = getValueAt(row, column);
        return ob == null ? 0 : (new BigDecimal(ob.toString())).longValue();
    }

    public long getLong(int row, String columnName) {
        Object ob = getValueAt(row, columnName);
        return ob == null ? 0 : (new BigDecimal(ob.toString())).longValue();
    }

    /**
     * get a double value
     */
    public double getDouble(int row, int column) {
        Object ob = getValueAt(row, column);
        return ob == null ? 0 : (new BigDecimal(ob.toString())).doubleValue();
    }

    public double getDouble(int row, String columnName) {
        Object ob = getValueAt(row, columnName);
        return ob == null ? 0 : (new BigDecimal(ob.toString())).doubleValue();
    }

    /**
     * get a date value
     */
    public Date getDate(int row, int column) {
        Date oRet = null;
        Object ob = getValueAt(row, column);
        if (ob != null) {
            java.sql.Timestamp oTime = (java.sql.Timestamp) ob;
            oRet = new Date(oTime.getTime());
        }
        return oRet;
    }

    public Date getDate(int row, String columnName) {
        Date oRet = null;
        Object ob = getValueAt(row, columnName);
        if (ob != null) {
            java.sql.Timestamp oTime = (java.sql.Timestamp) ob;
            oRet = new Date(oTime.getTime());
        }
        return oRet;
    }

    /**
     * get a float value
     */
    public float getFloat(int row, int column) {
        Object ob = getValueAt(row, column);
        return ob == null ? 0 : (new BigDecimal(ob.toString())).floatValue();
    }

    public float getFloat(int row, String columnName) {
        Object ob = getValueAt(row, columnName);
        return ob == null ? 0 : (new BigDecimal(ob.toString())).floatValue();
    }

    /**
     * get a float value
     */
    public BigDecimal getBigDecimal(int row, int column) {
        Object ob = getValueAt(row, column);
        return ob == null ? null : (new BigDecimal(ob.toString()));
    }

    public BigDecimal getBigDecimal(int row, String columnName) {
        Object ob = getValueAt(row, columnName);
        return ob == null ? null : (new BigDecimal(ob.toString()));
    }

    /**
     * get a date value
     */
    public Timestamp getTimestamp(int row, int column) {
        Timestamp oRet = null;
        Object ob = getValueAt(row, column);
        if (ob != null) {
            oRet = (Timestamp) ob;
        }
        return oRet;
    }

    public Timestamp getTimestamp(int row, String columnName) {
        Timestamp oRet = null;
        Object ob = getValueAt(row, columnName);
        if (ob != null) {
            oRet = (Timestamp) ob;
        }
        return oRet;
    }

    public Double getDoubleObj(int row, int column) {
        Object ob = getValueAt(row, column);
        Double result = null;
        if (null != ob) {
            result = new Double(new BigDecimal(ob.toString()).doubleValue());
        }

        return result;
    }

    public Double getDoubleObj(int row, String columnName) {
        Object ob = getValueAt(row, columnName);
        Double result = null;
        if (null != ob) {
            result = new Double(new BigDecimal(ob.toString()).doubleValue());
        }

        return result;
    }

    public Integer getInteger(int row, int column) {
        Object ob = getValueAt(row, column);
        Integer result = null;
        if (null != ob) {
            result = new Integer(new BigDecimal(ob.toString()).intValue());
        }
        return result;
    }

    public Integer getInteger(int row, String columnName) {
        Object ob = getValueAt(row, columnName);
        Integer result = null;
        if (null != ob) {
            result = new Integer(new BigDecimal(ob.toString()).intValue());
        }
        return result;
    }
}
