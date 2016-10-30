package com.guloulou.helper;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;

/**
 *
 * @author kang.cunhua
 */
public class ConvertHelper {

    public ConvertHelper() {
    }

    /**
     * 根据输入流，获得String
     *
     * @param is
     * @param inEncodeType
     * @return
     * @throws java.lang.Exception
     * ex:getStringByStream(is,"GBK");
     */
    public String getStringByStream(InputStream is, String inEncodeType) throws Exception {
        String str = "";
        if (is != null) {
            InputStreamReader isr = new InputStreamReader(is, inEncodeType);
            // System.out.println("....encode:"+isr.getEncoding());
            BufferedReader read = new BufferedReader(isr);
            str = new String(read.readLine().getBytes(inEncodeType));

        }

        return str;

    }
}
