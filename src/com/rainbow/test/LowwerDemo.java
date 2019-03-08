/**
 * ****************************************************************************
 * System      : weaverTest
 * Module      : com.rainbow.test
 * File Name   : LowwerDemo.java
 * Description : TODO
 * History
 * Seq   Date        Developer      Description
 * ---------------------------------------------------------------------------
 * 1     2018年5月30日     zong.yq     Create by Generator
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
public class LowwerDemo {

	public static void main(String[] args) {

		//String a = "select gx, csxm, fb, qb, bmjd, csgx, jdycp, clz, jl, selectname as BZPD, CASE pdjg WHEN 0 THEN 'OK' WHEN 1 THEN 'NG' END AS pdjg, bz, wtcz, djdd, djrq, djz from (select A . ID, csgx AS gx, csxm, fb, qb, bmjd, b.jdycp AS csgx, A .jdycp AS jdycp, clz, CASE jl WHEN 0 THEN '1cm' WHEN 1 THEN '2.5cm' WHEN 2 THEN '30cm' END AS jl, bzpd, pdjg, bz, wtcz, djdd, djrq, djz from formtable_main_176_dt6 a, ( SELECT fm176.id, csgx, csxm, CASE fb WHEN 0 THEN '崇川' WHEN 1 THEN '合肥' WHEN 2 THEN '苏通' END AS fb, CASE qb WHEN 0 THEN 'A1' WHEN 1 THEN 'T1' WHEN 2 THEN 'A2' WHEN 3 THEN 'T2' WHEN 4 THEN 'A3' WHEN 5 THEN 'T3' WHEN 6 THEN '技术中心' WHEN 7 THEN '动力部' WHEN 8 THEN '合肥' WHEN 9 THEN '苏通' WHEN 10 THEN '2.5期' END AS qb, jdycp, wtcz, djdd, djrq, lastname AS djz FROM formtable_main_176 fm176, hrmresource hrm WHERE fm176.djz = hrm. ID ) b where a.mainid = b.id ) c left join ( SELECT * FROM workflow_selectitem WHERE fieldid = ( SELECT ID FROM workflow_billfield WHERE billid =-176 AND fieldname = 'bzpd') ) d ON D .SELECTVALUE = c.BZPD";
		//String a = "SELECT gx, xm, e.fb as fb, e.qb as qb, bmjd, sbbh as csgx, jdycp, clz, jl, bzpd, pdjg, bz, wtcz, djdd, djrq, djz from (select c.id, gx, csxm as xm, fb, qb, bmjd, jdcp, jdycp, clz, jl, selectname as bzpd, case pdjg when 0 then 'OK' when 1 then 'NG' end as pdjg, bz, wtcz, djdd, djrq, djz from (select a.id, csgx as gx, csxm, fb, qb, bmjd, jdcp, a .jdycp as jdycp, clz, case jl when 0 then '1cm' when 1 then '2.5cm' when 2 then '30cm' end as jl, bzpd, pdjg, bz, wtcz, djdd, djrq, djz from formtable_main_176_dt6 a, ( select fm176.id, csgx, csxm, case fb when 0 then '崇川' when 1 then '合肥' when 2 then '苏通' end as fb, case qb when 0 then 'A1' when 1 then 'T1' when 2 then 'A2' when 3 then 'T2' when 4 then 'A3' when 5 then 'T3' when 6 then '技术中心' when 7 then '动力部' when 8 then '合肥' when 9 then '苏通' when 10 then '2.5期' end as qb, jdycp, wtcz, djdd, djrq, lastname as djz from formtable_main_176 fm176, hrmresource hrm where fm176.djz = hrm. id ) b where a.mainid = b.id ) c left join ( select * from workflow_selectitem where fieldid = ( select id from workflow_billfield where billid =-176 and fieldname = 'bzpd') ) d on d .selectvalue = c.bzpd order by c.id ) e left join sbdjxx on e.jdcp = sbdjxx.id";
		//String a = "SELECT gx, case xm when 6 then '静电源&产品静电压' end as xm, e.fb AS fb, e.qb AS qb, bmjd, sbbh AS csgx, jdycp, clz, jl, bzpd, pdjg, bz, wtcz, djdd, djrq, djz, zhdjsj, djpl FROM (SELECT c.id, gx, xm, fb, qb, bmjd, jdcp, jdycp, clz, jl, selectname AS bzpd, CASE pdjg WHEN 0 THEN 'ok' WHEN 1 THEN 'ng' END AS pdjg, bz, wtcz, djdd, djrq, djz FROM (SELECT a.id, csgx AS gx, xm, fb, qb, bmjd, jdcp, a .jdycp AS jdycp, clz, CASE jl WHEN 0 THEN '1cm' WHEN 1 THEN '2.5cm' WHEN 2 THEN '30cm' END AS jl, bzpd, pdjg, bz, wtcz, djdd, djrq, djz FROM formtable_main_89_dt6 a, (SELECT fm89.id, csgx, xm, CASE fb WHEN 0 THEN '崇川' WHEN 1 THEN '合肥' WHEN 2 THEN '苏通' END AS fb, CASE qb WHEN 0 THEN 'A1' WHEN 1 THEN 'T1' WHEN 2 THEN 'A2' WHEN 3 THEN 'T2' WHEN 4 THEN 'A3' WHEN 5 THEN 'T3' WHEN 6 THEN '技术中心' WHEN 7 THEN '动力部' WHEN 8 THEN '合肥' WHEN 9 THEN '苏通' WHEN 10 THEN '2.5期' END AS qb, jdycp, wtcz, djdd, djrq, lastname AS djz FROM formtable_main_89 fm89, hrmresource hrm WHERE fm89.djz = hrm. id ) b WHERE a.mainid = b.id ) c LEFT JOIN (SELECT * FROM workflow_selectitem WHERE fieldid = (SELECT id FROM workflow_billfield WHERE billid =-89 AND fieldname = 'bzpd') ) d ON d .selectvalue = c.bzpd ORDER BY c.id ) e LEFT JOIN sbdjxx ON e.jdcp = sbdjxx.id ORDER BY e.id";
		String a = "SELECT gx, xm, E .fb AS fb, E .qb AS qb, bmjd, sbbh AS csgx, jdycp, clz, jl, bzpd, pdjg, bz, wtcz, djdd, djrq, djz, zhdjsj, djpl FROM ( SELECT x. ID, gx, y.selectname AS xm, fb, qb, bmjd, jdcp, jdycp, clz, jl, bzpd, pdjg, bz, wtcz, djdd, djrq, djz FROM ( SELECT c. ID, gx, xm, fb, qb, bmjd, jdcp, jdycp, clz, jl, selectname AS bzpd, CASE pdjg WHEN 0 THEN 'ok' WHEN 1 THEN 'ng' END AS pdjg, bz, wtcz, djdd, djrq, djz FROM ( SELECT A . ID, csgx AS gx, xm, fb, qb, bmjd, jdcp, A .jdycp AS jdycp, clz, CASE jl WHEN 0 THEN '1cm' WHEN 1 THEN '2.5cm' WHEN 2 THEN '30cm' END AS jl, bzpd, pdjg, bz, wtcz, djdd, djrq, djz FROM formtable_main_89_dt6 A, ( SELECT fm89. ID, csgx, xm, CASE fb WHEN 0 THEN '崇川' WHEN 1 THEN '合肥' WHEN 2 THEN '苏通' END AS fb, CASE qb WHEN 0 THEN 'A1' WHEN 1 THEN 'T1' WHEN 2 THEN 'A2' WHEN 3 THEN 'T2' WHEN 4 THEN 'A3' WHEN 5 THEN 'T3' WHEN 6 THEN '技术中心' WHEN 7 THEN '动力部' WHEN 8 THEN '合肥' WHEN 9 THEN '苏通' WHEN 10 THEN '2.5期' END AS qb, jdycp, wtcz, djdd, djrq, lastname AS djz FROM formtable_main_89 fm89, hrmresource hrm WHERE fm89.djz = hrm. ID ) b WHERE A .mainid = b. ID ) c LEFT JOIN ( SELECT * FROM workflow_selectitem WHERE fieldid = ( SELECT ID FROM workflow_billfield WHERE billid =- 89 AND fieldname = 'bzpd' ) ) D ON D .selectvalue = c.bzpd ) x LEFT JOIN ( SELECT * FROM workflow_selectitem WHERE fieldid = ( SELECT ID FROM workflow_billfield WHERE billid =- 89 AND fieldname = 'xm' ) ) y ON y.selectvalue = x.xm ) E LEFT JOIN sbdjxx ON E .jdcp = sbdjxx. ID ORDER BY E . ID";
		String b = "";

		b = a.toLowerCase();

		System.out.println(b);

	}

}
