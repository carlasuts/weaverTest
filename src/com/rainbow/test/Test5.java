package com.rainbow.test;

import java.lang.reflect.Field;

public class Test5 {

    public static void main(String args[]) {
//        String source = "[{\"resv_FIELD3\":null,\"resv_FIELD4\":\"bubububu\",\"update_TIME\":\"20160721091450\",\"resv_FIELD1\":\"121254\",\"resv_FIELD2\":\"1\",\"flag\":\"0\",\"resv_FIELD7\":null,\"resv_FIELD8\":null,\"resv_FIELD5\":null,\"resv_FIELD6\":null,\"program_ID\":null,\"pkld\":\"RDL+Bump\",\"resv_FIELD9\":null,\"resv_FIELD20\":null,\"lot_ID\":\"5055320-01\",\"pass_QTY\":13751,\"res_ID\":\"DX-003\",\"id\":22,\"cpyc_SUBLOT_LIST\":[{\"resv_FIELD3\":null,\"resv_FIELD4\":null,\"resv_FIELD1\":null,\"topbin3_QTY\":0,\"resv_FIELD2\":null,\"resv_FIELD7\":null,\"topbin2_FAIL_YIELD\":\"0\",\"resv_FIELD8\":null,\"resv_FIELD5\":null,\"resv_FIELD6\":null,\"topbin1_QTY\":1013,\"resv_FIELD9\":null,\"topbin3_FAIL_YIELD\":\"0\",\"sublot_ID\":\"5055320-22\",\"topbin3_PROMPT\":null,\"topbin2_PROMPT\":null,\"topbin1_FAIL_YIELD\":\"0.136413\",\"resv_FIELD10\":null,\"topbin1_PROMPT\":\"BIN4\",\"topbin2_QTY\":0,\"id\":22},{\"resv_FIELD3\":null,\"resv_FIELD4\":null,\"resv_FIELD1\":null,\"topbin3_QTY\":0,\"resv_FIELD2\":null,\"resv_FIELD7\":null,\"topbin2_FAIL_YIELD\":\"0\",\"resv_FIELD8\":null,\"resv_FIELD5\":null,\"resv_FIELD6\":null,\"topbin1_QTY\":1013,\"resv_FIELD9\":null,\"topbin3_FAIL_YIELD\":\"0\",\"sublot_ID\":\"5055320-23\",\"topbin3_PROMPT\":null,\"topbin2_PROMPT\":null,\"topbin1_FAIL_YIELD\":\"0.136413\",\"resv_FIELD10\":null,\"topbin1_PROMPT\":\"BIN4\",\"topbin2_QTY\":0,\"id\":22},{\"resv_FIELD3\":null,\"resv_FIELD4\":null,\"resv_FIELD1\":null,\"topbin3_QTY\":12,\"resv_FIELD2\":null,\"resv_FIELD7\":null,\"topbin2_FAIL_YIELD\":\"0.00201993\",\"resv_FIELD8\":null,\"resv_FIELD5\":null,\"resv_FIELD6\":null,\"topbin1_QTY\":913,\"resv_FIELD9\":null,\"topbin3_FAIL_YIELD\":\"0.00161594\",\"sublot_ID\":\"5055320-24\",\"topbin3_PROMPT\":\"BIN1\",\"topbin2_PROMPT\":\"BIN39\",\"topbin1_FAIL_YIELD\":\"0.122946\",\"resv_FIELD10\":null,\"topbin1_PROMPT\":\"BIN2\",\"topbin2_QTY\":15,\"id\":22}],\"total_YIELD\":\"61.725\",\"fxno\":null,\"cust_RUN_ID\":\"5055320\",\"input_QTY\":22278,\"create_DATE\":\"2016042121\",\"resv_FIELD14\":null,\"resv_FIELD15\":null,\"resv_FIELD16\":null,\"resv_FIELD17\":null,\"resv_FIELD10\":null,\"user_ID\":\"EVIL\",\"resv_FIELD11\":null,\"resv_FIELD12\":null,\"resv_FIELD13\":null,\"mat_DESC\":\"656-MT6332P/BHDC-Q-H\",\"oper\":\"WC2200\",\"resv_FIELD18\":null,\"cust_ID\":\"317\",\"resv_FIELD19\":null,\"assylot\":null}]";
//
//        System.out.println(source.length());

//        source = source.substring(1, source.length() - 1);
//        System.out.println(source);
//        String a = "171503,162806";
//        String a1 = "171503，162806";
//        String regex = ",|，|\\s+";
//        String c = "";
//        String as[] = a1.split(regex);
//        for (String b : as) {
//            System.out.println(b);
//        }
//        String fileNo = "TEST12";
//        String name = "TEST";
//        int no = Integer.valueOf(fileNo.substring(name.length(), fileNo.length()));
//        no = no + 1;
//        fileNo = name + String.valueOf(no);
//        System.out.println(fileNo);
        Integer a = 1;
        Integer b = 2;
        System.out.printf("a = %s, b = %s\n", a, b);
        swap(a, b);
        System.out.printf("a = %s, b = %s\n", a, b);
    }

    public static void swap(Integer a, Integer b) {
        // 以下是错误方法
//        Integer temp = a;
//        a = b;
//        b = temp;
        int temp = a.intValue();
        try {
            Field value = Integer.class.getDeclaredField("value");
            value.setAccessible(true);
            value.set(a, b);
            value.set(b, new Integer(temp));
        } catch (NoSuchFieldException e) {
            e.printStackTrace();
        } catch (IllegalAccessException e) {
            e.printStackTrace();
        }
    }
}
