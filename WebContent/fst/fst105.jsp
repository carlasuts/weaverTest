<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ page
	import="java.sql.Connection,java.sql.DriverManager,java.sql.PreparedStatement,java.sql.ResultSet,weaver.general.Util"%>
<%@ page import="java.util.*"%>
<%@ include file="/systeminfo/init.jsp"%>

<jsp:useBean id="mysmt" class="weaver.conn.RecordSet" />
<jsp:useBean id="bs" class="weaver.general.BaseBean"></jsp:useBean>
<%
	int requestid = Util.getIntValue(request.getParameter("requestid"),0);//请求id
	int workflowid = Util.getIntValue(request.getParameter("workflowid"), 0);//流程id
	int formid = Util.getIntValue(request.getParameter("formid"), 0);//表单id
	int isbill = Util.getIntValue(request.getParameter("isbill"), 0);//表单类型，1单据，0表单
	int nodeid = Util.getIntValue(request.getParameter("nodeid"), 0);//流程的节点id
	int userId = user.getUID();
%>
<script>
    jQuery(function () {
        //不是第一个节点
        <%if(nodeid == 350){%>
        /*
        	jQuery("#field6301").blur(function() {f_get();});
        	jQuery("#field6299").attr("readonly",true);//ph
            jQuery("#field6300").attr("readonly",true);//khh
            jQuery("#field6302").attr("readonly",true);//pm
            jQuery("#field6303").attr("readonly",true);//fzlx
            jQuery("#field6304").attr("readonly",true);//jbkj
            jQuery("#field6305").attr("readonly",true);//xpcc
            jQuery("#field6306").attr("readonly",true);//jhs
            jQuery("#field6307").attr("readonly",true);//zhj
            jQuery("#field6308").attr("readonly",true);//sfl
            jQuery("#field6309").attr("readonly",true);//dd
            */
		<%} else {%>
			var tr11 = jQuery("#field6318").val();
			var tr12 = jQuery("#field6371").val();
			var tr13 = jQuery("#field6366").val();
			var tr14 = jQuery("#field6336").val();
			var tr15 = jQuery("#field6340").val();
			tr11 = jQuery.trim(tr11);
			tr12 = jQuery.trim(tr12);
			tr13 = jQuery.trim(tr13);
			tr14 = jQuery.trim(tr14);
			tr15 = jQuery.trim(tr15);
			if(tr11 == "" && tr12 == "" && tr13 == "" && tr14 == "" && tr15 == ""){
				jQuery("#tr1").hide();
			}
			
			var tr21 = jQuery("#field6403").val();
			var tr22 = jQuery("#field6319").val();
			var tr23 = jQuery("#field6372").val();
			var tr24 = jQuery("#field6349").val();
			var tr25 = jQuery("#field6350").val();
			var tr26 = jQuery("#field6351").val();
			var tr27 = jQuery("#field6378").val();
			var tr28 = jQuery("#field6379").val();
			var tr29 = jQuery("#field6380").val();
			var tr210 = jQuery("#field6381").val();
			var tr211 = jQuery("#field6382").val();
			var tr212 = jQuery("#field6337").val();
			var tr213 = jQuery("#field6345").val();
			tr21 = jQuery.trim(tr21);
			tr22 = jQuery.trim(tr22);
			tr23 = jQuery.trim(tr23);
			tr24 = jQuery.trim(tr24);
			tr25 = jQuery.trim(tr25);
			tr26 = jQuery.trim(tr26);
			tr27 = jQuery.trim(tr27);
			tr28 = jQuery.trim(tr28);
			tr29 = jQuery.trim(tr29);
			tr210 = jQuery.trim(tr210);
			tr211 = jQuery.trim(tr211);
			tr212 = jQuery.trim(tr212);
			tr213 = jQuery.trim(tr213);
			if(tr21 == "0" && tr22 == "" && tr23 == "" && tr24 == "0" && tr25 == "0" && tr26 == "0" && tr27 == "" && tr28 == "" && tr29 == "" && tr210 == "" && tr211 == "" && tr212 == "" && tr213 == ""){
				jQuery("#tr2").hide();
			}
			if(tr24 == "0"){
				jQuery("#p6349").hide();
			}
			if(tr25 == "0"){
				jQuery("#p6350").hide();
			}
			if(tr26 == "0"){
				jQuery("#p6351").hide();
			}
			
			var tr31 = jQuery("#field6321").val();
			var tr32 = jQuery("#field6373").val();
			var tr33 = jQuery("#field6352").val();
			var tr34 = jQuery("#field6353").val();
			var tr35 = jQuery("#field6354").val();
			var tr36 = jQuery("#field6383").val();
			var tr37 = jQuery("#field6384").val();
			var tr38 = jQuery("#field6385").val();
			var tr39 = jQuery("#field6386").val();
			var tr310 = jQuery("#field6387").val();
			var tr311 = jQuery("#field6338").val();
			var tr312 = jQuery("#field6341").val();
			tr31 = jQuery.trim(tr31);
			tr32 = jQuery.trim(tr32);
			tr33 = jQuery.trim(tr33);
			tr34 = jQuery.trim(tr34);
			tr35 = jQuery.trim(tr35);
			tr36 = jQuery.trim(tr36);
			tr37 = jQuery.trim(tr37);
			tr38 = jQuery.trim(tr38);
			tr39 = jQuery.trim(tr39);
			tr310 = jQuery.trim(tr310);
			tr311 = jQuery.trim(tr311);
			tr312 = jQuery.trim(tr312);
			if(tr31 == "" && tr32 == "" && tr33 == "0" && tr34 == "0" && tr35 == "0" && tr36 == "" && tr37 == "" && tr38 == "" && tr39 == "" && tr310 == "" && tr311 == "" && tr312 == ""){
				jQuery("#tr3").hide();
			}
			if(tr33 == "0"){
				jQuery("#p6352").hide();
			}
			if(tr34 == "0"){
				jQuery("#p6353").hide();
			}
			if(tr35 == "0"){
				jQuery("#p6354").hide();
			}
			
			var tr41 = jQuery("#field6332").val();
			var tr42 = jQuery("#field6374").val();
			var tr43 = jQuery("#field6355").val();
			var tr44 = jQuery("#field6356").val();
			var tr45 = jQuery("#field6357").val();
			var tr46 = jQuery("#field6358").val();
			var tr47 = jQuery("#field6388").val();
			var tr48 = jQuery("#field6389").val();
			var tr49 = jQuery("#field6390").val();
			var tr410 = jQuery("#field6391").val();
			var tr411 = jQuery("#field6392").val();
			var tr412 = jQuery("#field6339").val();
			var tr413 = jQuery("#field6346").val();
			tr41 = jQuery.trim(tr41);
			tr42 = jQuery.trim(tr42);
			tr43 = jQuery.trim(tr43);
			tr44 = jQuery.trim(tr44);
			tr45 = jQuery.trim(tr45);
			tr46 = jQuery.trim(tr46);
			tr47 = jQuery.trim(tr47);
			tr48 = jQuery.trim(tr48);
			tr49 = jQuery.trim(tr49);
			tr410 = jQuery.trim(tr410);
			tr411 = jQuery.trim(tr411);
			tr412 = jQuery.trim(tr412);
			tr413 = jQuery.trim(tr413);
			if(tr41 == "" && tr42 == "" && tr43 == "0" && tr44 == "0" && tr45 == "0" && tr46 == "0" && tr47 == "" && tr48 == "" && tr49 == "" && tr410 == "" && tr411 == "" && tr412 == "" && tr413 == ""){
				jQuery("#tr4").hide();
			}
			if(tr43 == "0"){
				jQuery("#p6355").hide();
			}
			if(tr44 == "0"){
				jQuery("#p6356").hide();
			}
			if(tr45 == "0"){
				jQuery("#p6357").hide();
			}
			if(tr46 == "0"){
				jQuery("#p6358").hide();
			}
			
			var tr51 = jQuery("#field6333").val();
			var tr52 = jQuery("#field6375").val();
			var tr53 = jQuery("#field6359").val();
			var tr54 = jQuery("#field6360").val();
			var tr55 = jQuery("#field6361").val();
			var tr56 = jQuery("#field6362").val();
			var tr57 = jQuery("#field6393").val();
			var tr58 = jQuery("#field6394").val();
			var tr59 = jQuery("#field6395").val();
			var tr510 = jQuery("#field6396").val();
			var tr511 = jQuery("#field6397").val();
			var tr512 = jQuery("#field6343").val();
			var tr513 = jQuery("#field6347").val();
			tr51 = jQuery.trim(tr51);
			tr52 = jQuery.trim(tr52);
			tr53 = jQuery.trim(tr53);
			tr54 = jQuery.trim(tr54);
			tr55 = jQuery.trim(tr55);
			tr56 = jQuery.trim(tr56);
			tr57 = jQuery.trim(tr57);
			tr58 = jQuery.trim(tr58);
			tr59 = jQuery.trim(tr59);
			tr510 = jQuery.trim(tr510);
			tr511 = jQuery.trim(tr511);
			tr512 = jQuery.trim(tr512);
			tr513 = jQuery.trim(tr513);
			if(tr51 == "" && tr52 == "" && tr53 == "0" && tr54 == "0" && tr55 == "0" && tr56 == "0" && tr57 == "" && tr58 == "" && tr59 == "" && tr510 == "" && tr511 == "" && tr512 == "" && tr513 == ""){
				jQuery("#tr5").hide();
			}
			if(tr53 == "0"){
				jQuery("#p6359").hide();
			}
			if(tr54 == "0"){
				jQuery("#p6360").hide();
			}
			if(tr55 == "0"){
				jQuery("#p6361").hide();
			}
			if(tr56 == "0"){
				jQuery("#p6362").hide();
			}
			
			var tr61 = jQuery("#field6334").val();
			var tr62 = jQuery("#field6376").val();
			var tr63 = jQuery("#field6363").val();
			var tr64 = jQuery("#field6364").val();
			var tr65 = jQuery("#field6365").val();
			var tr66 = jQuery("#field6398").val();
			var tr67 = jQuery("#field6399").val();
			var tr68 = jQuery("#field6400").val();
			var tr69 = jQuery("#field6401").val();
			var tr610 = jQuery("#field6402").val();
			var tr611 = jQuery("#field6344").val();
			var tr612 = jQuery("#field6348").val();
			tr61 = jQuery.trim(tr61);
			tr62 = jQuery.trim(tr62);
			tr63 = jQuery.trim(tr63);
			tr64 = jQuery.trim(tr64);
			tr65 = jQuery.trim(tr65);
			tr66 = jQuery.trim(tr66);
			tr67 = jQuery.trim(tr67);
			tr68 = jQuery.trim(tr68);
			tr69 = jQuery.trim(tr69);
			tr610 = jQuery.trim(tr610);
			tr611 = jQuery.trim(tr611);
			tr612 = jQuery.trim(tr612);
			if(tr61 == "" && tr62 == "" && tr63 == "0" && tr64 == "0" && tr65 == "0" && tr66 == "" && tr67 == "" && tr68 == "" && tr69 == "" && tr610 == "" && tr611 == "" && tr612 == ""){
				jQuery("#tr6").hide();
			}
			if(tr63 == "0"){
				jQuery("#p6363").hide();
			}
			if(tr64 == "0"){
				jQuery("#p6364").hide();
			}
			if(tr65 == "0"){
				jQuery("#p6365").hide();
			}
			
			var tr71 = jQuery("#field6335").val();
			var tr72 = jQuery("#field6377").val();
			var tr73 = jQuery("#field6367").val();
			var tr74 = jQuery("#field6370").val();
			var tr75 = jQuery("#field6368").val();
			tr71 = jQuery.trim(tr71);
			tr72 = jQuery.trim(tr72);
			tr73 = jQuery.trim(tr73);
			tr74 = jQuery.trim(tr74);
			tr75 = jQuery.trim(tr75);
			if(tr71 == "" && tr72 == "" && tr73 == "" && tr74 == "" && tr75 == ""){
				jQuery("#tr7").hide();
			}
		<%}%>
	});
    function f_get(){
    	jQuery.ajax({
            url: "/interface/ff/kkxsyajax.jsp",
            data: { lotid: jQuery("#field6301").val() },
            cache: false,
            async: false,
            type: "post",
            dataType: "text",
            success: function (result) {
            	result = jQuery.trim(result);
            	var tmp = result.split(",");
                jQuery("#field6299").val(tmp[0]);//ph
                jQuery("#field6300").val(tmp[1]);//khh
                jQuery("#field6302").val(tmp[2]);//pm
                jQuery("#field6303").val(tmp[3]);//fzlx
                jQuery("#field6304").val(tmp[4]);//jbkj
                jQuery("#field6305").val(tmp[5]);//xpcc
                jQuery("#field6306").val(tmp[6]);//jhs
                jQuery("#field6307").val(tmp[7]);//zhj
                jQuery("#field6308").val(tmp[8]);//sfl
                jQuery("#field6309").val(tmp[9]);//dd
            }
        });
    }
</script>