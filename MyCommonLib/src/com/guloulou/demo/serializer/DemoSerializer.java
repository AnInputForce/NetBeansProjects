/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.guloulou.demo.serializer;

import java.io.File;
import org.simpleframework.xml.Attribute;
import org.simpleframework.xml.Element;
import org.simpleframework.xml.Root;
import org.simpleframework.xml.Serializer;
import org.simpleframework.xml.core.Persister;

/**
 *
 * @author kang.cunhua
 */
@Root
public class DemoSerializer {

    @Attribute
    private String type;
    @Element
    private String company;
    @Element
    private int quantityInStock;
    @Element
    private String model;

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getCompany() {
        return company;
    }

    public void setCompany(String company) {
        this.company = company;
    }

    public int getQuantityInStock() {
        return quantityInStock;
    }

    public void setQuantityInStock(int quantityInStock) {
        this.quantityInStock = quantityInStock;
    }

    public String getModel() {
        return model;
    }

    public void setModel(String model) {
        this.model = model;
    }

    public static void main(String[] args) {
        Serializer serializer = new Persister();
        DemoSerializer lure = new DemoSerializer();
        try {
            // 序列化

            //lure.setCompany("Donzai");
            lure.setCompany("中石化");
            lure.setModel("Marlin Buster");
            lure.setQuantityInStock(23);
            lure.setType("Trolling");

            File result = new File(System.getProperty("user.dir") + "/resource/lure.xml");
            serializer.write(lure, result);
            // 反序列化

            serializer = new Persister();
            File source = new File(System.getProperty("user.dir") + "/resource/lure.xml");
            lure = serializer.read(DemoSerializer.class, source);

            System.out.println(lure.getCompany());
            System.out.println(lure.getModel());
            System.out.println(lure.getQuantityInStock());
            System.out.println(lure.getType());
        } catch (Exception e) {
            e.printStackTrace();
        }

    }
}
