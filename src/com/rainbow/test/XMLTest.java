package com.rainbow.test;

import org.dom4j.Attribute;
import org.dom4j.Document;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;

import java.util.Iterator;

public class XMLTest {

    public static void main(String args[]) {
        Document document = null;
        String xmlResult = "<?xml version=\"1.0\" encoding=\"UTF-8\"?><users><user id=\"10001\"><name>张三</name><role>群主</role><sex>男</sex><content>今天天气真不错！</content><time>2016-04-25 16:43:28</time></user><user id=\"10002\"> <name>李四</name><role>管理员</role><sex>男</sex><content>http://192.168.0.190:9999/beike/data/b3217f668.png</content><time>2016-04-25 16:45:08</time></user></users>";
        try {
            document = DocumentHelper.parseText(xmlResult);
        } catch (Exception e) {
            e.printStackTrace();
        }
        Element rootElement = document.getRootElement();
        for (Iterator iter = rootElement.elementIterator(); iter.hasNext();) {
            Element element = (Element) iter.next();
            Attribute attr = element.attribute("id");
            if (null != attr) {
                String attrVal = attr.getValue();
                String attrName = attr.getName();
                System.out.println(attrName + " : " + attrVal);
            }
            for (Iterator iterator = element.elementIterator(); iterator.hasNext();) {
                Element elementOption = (Element) iterator.next();
                String tagName = elementOption.getName();
                String tagContent = elementOption.getTextTrim();
                System.out.println(tagName + " : " + tagContent);
            }
        }
    }

}
