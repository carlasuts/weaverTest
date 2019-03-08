/**
 * ****************************************************************************
 * System      : weaverTest
 * Module      : com.rainbow.test
 * File Name   : Upper.java
 * Description : TODO
 * History
 * Seq   Date        Developer      Description
 * ---------------------------------------------------------------------------
 * 1     2018年8月30日     zong.yq     Create by Generator
 *
 * Copyright(C) 2017 NT,Inc.
 * All rights reserved.
 ****************************************************************************
 */
package com.rainbow.test;

/**
 * @author zong.yq
 * 
 */
public class Upper {

	/**
	 * @param args
	 */
	public static void main(String[] args) {

//		String a = "SELECT Adv_mat_assy, Oth_mat_assy, Mat_com_assy, artifi_assy, power_assy, deprect_assy, maintain_assy, other_assy, thou_tal_cost_assy, tester_time, hander_time, mat_time, " +
//		  "artifi_time, power_time, deprect_time, maintain_time, other_time, test_tal_cost_time, tester_thou, hander_thou, mat_thou, artifi_thou, power_thou, deprect_thou, maintain_thou, " +
//		  "other_thou, test_tal_cost_thou, form_pack, grade_pack, mat_pack, artifi_pack, power_pack, deprect_pack, maintain_pack, other_pack, pack_tal_cost_pack, mat_totl, Artif_totl, " +
//		  "power_totl, deprec_totl, maint_totl, other_totl, total_cost_totl, b.WIRE_BOND_FAST, b.FRAMEWORK_TECH_FAST, b.ENCAPSULA_MAT_FAST, b.MAT_FAST, wire_bond_price, frame_price, " +
//		  "molding_price, slice_price, currency, b.TEST_QUOTATION_WAY_FAST, a.shape, a.exchange_rate " +
//		  "from formtable_main_205 a left join Offer_to_apply_middle b on a.guid = b.ID where a.requestid =''";
//		a = a.toUpperCase();
//		
//		System.out.println(a);
		
//		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
//		Date date = new Date();
//		String time = sdf.format(date);
//		
//		try {
//			date = sdf.parse(time);
//			Date date1 = sdf.parse("20180825");
//			
//			long days = (date.getTime() - date1.getTime()) / (1000 * 60 * 60 * 24);
//			
//			System.out.println(days);
//		} catch (ParseException e) {
//			e.printStackTrace();
//		}
		
//		String time = "20180829091100";
//		
//		time = time.substring(0,8);
//		
//		System.out.println(time);
//		Map<String, String> map = new HashMap<String, String>();
//		String a = "20180903163150";
//		a = a.substring(0, 8);
//		System.out.println(a);
		
//		Map<String, String> map = new HashMap<String, String>();
//		map.put("1", "1");
//		map.put("2", "2");
//		map.put("3", "3");
//		
//		List list = new ArrayList();
//		List list1 = new ArrayList();
//		list1.add(list);
//		String date = "2018-09-19";
//		String month = date.substring(5,7);
//		String year = date.substring(2,4);
//		Calendar cal = Calendar.getInstance();
//		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
//		try {
//			cal.setTime(sdf.parse(date));
//		} catch (ParseException e) {
//			e.printStackTrace();
//		}
//		String week = String.valueOf(cal.get(Calendar.WEEK_OF_YEAR));
//		System.out.println(year);
//		System.out.println(month);
//		System.out.println(week);
//		String l = "24208";
//		String[] names = l.split(",");
//		for (String name : names) {
//			System.out.println(name);
//		}
//		List<String> list = new ArrayList<String>();
//
//		for (int i = 0; i < 4; i++) {
//			list.add(String.valueOf(i));
//		}
//
//		System.out.println(list);
//		list.remove(list.size() - 1);
//		System.out.println(list);

		String tagValue = "SalesQuoteCollection('00163E7329D91ED8BFCF640EEB3A281C')";
		System.out.println("原来的值:" + tagValue);
		tagValue = tagValue.replace("'", "''");
        System.out.println("后来的值:" + tagValue);
	}

}
