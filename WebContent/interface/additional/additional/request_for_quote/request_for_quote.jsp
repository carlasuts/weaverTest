<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/systeminfo/init_wev8.jsp"%>
<%@ page import="weaver.general.Util,java.util.List,java.util.ArrayList"%>
<%@ page import="weaver.general.Util,java.text.*,weaver.conn.*,weaver.soa.workflow.request.*" %>
<%@ page import="java.util.*" %>
<%@ page import="weaver.file.*" %>
<%@ page import="java.text.*" %>
<%@ taglib uri="/WEB-INF/tld/browser.tld" prefix="brow"%>
<HTML>
<HEAD>
<LINK REL=stylesheet type=text/css HREF=/css/Weaver_wev8.css>
</HEAD>
<SCRIPT language="javascript" src="/js/weaver_wev8.js"></script>
<script language=javascript src="/js/jquery/jquery-1.4.2.min_wev8.js"></script>
<%
	String imagefilename = "/images/hdMaintenance.gif";
	String titlename = "报价申请规则";
%>
<%

%>
<BODY>
	<%@ include file="/systeminfo/TopTitle_wev8.jsp"%>
	<%@ include file="/systeminfo/RightClickMenuConent_wev8.jsp"%>
	<%
		//保存
		RCMenu += "{" + SystemEnv.getHtmlLabelName(86, user.getLanguage()) + ",javascript:doSave(this),_self} ";
		RCMenuHeight += RCMenuHeightStep;
		//返回
		RCMenu += "{" + SystemEnv.getHtmlLabelName(1290, user.getLanguage()) + ",javascript:location.href='with_other_fees.jsp',_self} ";
		RCMenuHeight += RCMenuHeightStep;
	%>
	<%@ include file="/systeminfo/RightClickMenu_wev8.jsp"%>
	<table width=100% height=100% border="0" cellspacing="0"
		cellpadding="0">
		<colgroup>
			<col width="10">
			<col width="">
			<col width="10">
		</colgroup>
		<tr>
			<td height="10" colspan="3"></td>
		</tr>
		<tr>
			<td></td>
			<td valign="top">
				<FORM id=weaver NAME=frmmain STYLE="margin-bottom: 0" action="with_other_feesoperation.jsp" method=post>
					<table style="width: 80%" class=ListStyle>
						<TBODY>
							<TR>
								<td align="right">报价类型设定：</td>
								<td align="left">
								<a href="http://172.16.60.63:8080/interface/additional/management_office/request_for_quote/quotation_form_set/quotation_form_set.jsp" ></a>									
								</td>
							</TR>
							<TR>
								<td align="right">核决权限：</td>
								<td align="left">
								<a href="http://172.16.60.63:8080/interface/additional/management_office/request_for_quote/quotation_form_set/quotation_form_set.jsp" ></a>									
								</td>
							</TR>
							<TR>
								<td align="right">生产方式成本元素设定：</td>
								<td align="left">
								<a href="http://172.16.60.63:8080/interface/additional/management_office/request_for_quote/quotation_form_set/quotation_form_set.jsp" ></a>									
								</td>
							</TR>
							<TR>
								<td align="right">报价原因设定：</td>
								<td align="left">
								<a href="http://172.16.60.63:8080/interface/additional/management_office/request_for_quote/quotation_form_set/quotation_form_set.jsp" ></a>									
								</td>
							</TR>
							<TR>
								<td align="right">销售方式材料价格影响设定表：</td>
								<td align="left">
								<a href="http://172.16.60.63:8080/interface/additional/management_office/request_for_quote/materials_prices_set/materials_prices_set.jsp" >销售方式材料价格影响设定表</a>									
								</td>
							</TR>
							<TR>
								<td align="right">工厂精算人员设定表：</td>
								<td align="left">
								<a href="http://172.16.60.63:8080/interface/additional/management_office/request_for_quote/quotation_form_set/quotation_form_set.jsp" ></a>									
								</td>
							</TR>
							<TR>
								<td align="right">成交价格调整原因：</td>
								<td align="left">
								<a href="http://172.16.60.63:8080/interface/additional/management_office/request_for_quote/quotation_form_set/quotation_form_set.jsp" ></a>									
								</td>
							</TR>
							<TR>
								<td align="right">价格存储单位设定：</td>
								<td align="left">
								<a href="http://172.16.60.63:8080/interface/additional/management_office/request_for_quote/quotation_form_set/quotation_form_set.jsp" ></a>									
								</td>
							</TR>
							<TR>
								<td align="right">外形报价备注表：</td>
								<td align="left">
								<a href="http://172.16.60.63:8080/interface/additional/management_office/request_for_quote/quotation_note_table_shape/quotation_note_table_shape.jsp" >外形报价备注</a>									
								</td>
							</TR>
							<TR>
								<td align="right">键合成本设定：</td>
								<td align="left">
								<a href="http://172.16.60.63:8080/interface/additional/management_office/request_for_quote/wire_type_name_set/wire_type_name_set.jsp" >键合丝类型名称设定</a>									
								</td>
								<td align="left">
								<a href="http://172.16.60.63:8080/interface/additional/management_office/request_for_quote/wire_type_set/wire_type_set.jsp" >键合丝种类设定</a>									
								</td>
								<td align="left">
								<a href="http://172.16.60.63:8080/interface/additional/management_office/request_for_quote/set_wire_diameter/set_wire_diameter.jsp" >线径设定</a>									
								</td>
								<td align="left">
								<a href="http://172.16.60.63:8080/interface/additional/management_office/request_for_quote/unit_price_set/unit_price_set.jsp" >单价设定</a>									
								</td>
								<td align="left">
								<a href="http://172.16.60.63:8080/interface/additional/management_office/request_for_quote/quotation_form_set/quotation_form_set.jsp" ></a>									
								</td>
								<td align="left">
								<a href="http://172.16.60.63:8080/interface/additional/management_office/request_for_quote/shape_keys_wire_setting/shape_keys_wire_setting.jsp" >外形键合成本设定</a>									
								</td>
							</TR>
							<TR>
								<td align="right">贸易方式税点设定</td>
								<td align="left">
								<a href="http://172.16.60.63:8080/interface/additional/management_office/request_for_quote/tax_point_set/tax_point_set.jsp" >贸易方式税点设定</a>									
								</td>
							</TR>
							<TR>
								<td align="right">芯片成本设定：</td>
								<td align="left">
								<a href="http://172.16.60.63:8080/interface/additional/management_office/request_for_quote/quotation_form_set/quotation_form_set.jsp" >芯片大小设定</a>									
								</td>
								<td align="left">
								<a href="http://172.16.60.63:8080/interface/additional/management_office//request_for_quote/chip_cost_set_table_shape/chip_cost_set_table_shape.jsp" ></a>									
								</td>
								<td align="left">
								<a href="http://172.16.60.63:8080/interface/additional/management_office//request_for_quote/chip_cost_set_table_shape/chip_cost_set_table_shape.jsp" >外形芯片成本设定表</a>									
								</td>
								<td align="left">
								<a href="http://172.16.60.63:8080/interface/additional/management_office/request_for_quote/quotation_form_set/quotation_form_set.jsp" ></a>									
								</td>
								<td align="left">
								<a href="http://172.16.60.63:8080/interface/additional/management_office/request_for_quote/with_other_fees/with_other_fees.jsp" >装片其他费用</a>									
								</td>
								<td align="left">
								<a href="http://172.16.60.63:8080/interface/additional/management_office/request_for_quote/Load_piece_of_mat/Load_piece_of_mat.jsp" >装片材料设定</a>									
								</td>

							</TR>
							<TR>
								<td align="right">组装其他：</td>
								<td align="left">
								<a href="http://172.16.60.63:8080/interface/additional/management_office/request_for_quote/assy_other_categories/assy_other_categories.jsp" >组装其他类目</a>									
								</td>
								<td align="left">
								<a href="http://172.16.60.63:8080/interface/additional/management_office/request_for_quote/other_cost_item_table/other_cost_item_table.jsp" >组装其他成本项表</a>									
								</td>
								<td align="left">
								<a href="http://172.16.60.63:8080/interface/additional/management_office/request_for_quote/Assy_other_optional_table_item_cost/Assy_other_optional_table_item_cost.jsp" >组装其他成本项可选项表</a>									
								</td>
							</TR>
							<TR>
								<td align="right">测试成本设定：</td>
								<td align="left">
								<a href="http://172.16.60.63:8080/interface/additional/management_office/request_for_quote/testing_machine_maintenance/testing_machine_maintenance.jsp" >测试机维护</a>									
								</td>
								<td align="left">
								<a href="http://172.16.60.63:8080/interface/additional/management_office/request_for_quote/testing_machine_cost/testing_machine_cost.jsp" >测试机成本</a>									
								</td>
								<td align="left">
								<a href="http://172.16.60.63:8080/interface/additional/management_office/request_for_quote/shape_correspond_to_the_test_machine/shape_correspond_to_the_test_machine.jsp" >外形对应测试机</a>									
								</td>
								<td align="left">
								<a href="http://172.16.60.63:8080/interface/additional/management_office/request_for_quote/mechanical_maintenance/mechanical_maintenance.jsp" >机械手维护</a>									
								</td>
								<td align="left">
								<a href="http://172.16.60.63:8080/interface/additional/management_office/request_for_quote/cost_of_manipulator/cost_of_manipulator.jsp" >机械手成本</a>									
								</td>
								<td align="left">
								<a href="http://172.16.60.63:8080/interface/additional/management_office/request_for_quote/shape_correspond_to_manipulator/shape_correspond_to_manipulator.jsp" >外形对应机械手</a>									
								</td>
								<td align="left">
								<a href="http://172.16.60.63:8080/interface/additional/management_office/request_for_quote/appearance_test_UPH/appearance_test_UPH.jsp" >外形测试UPH</a>									
								</td>
							</TR>
							<TR>
								<td align="right">包装成本设定：</td>
								<td align="left">
								<a href="http://172.16.60.63:8080/interface/additional/management_office/request_for_quote/packaging_materials/packaging_materials.jsp" >包装材料</a>									
								</td>
								<td align="left">
								<a href="http://172.16.60.63:8080/interface/additional/management_office/request_for_quote/packing_grade/packing_grade.jsp" >包装档次</a>									
								</td>
								<td align="left">
								<a href="http://172.16.60.63:8080/interface/additional/management_office/request_for_quote/pack_cost/pack_cost.jsp" >包装成本</a>									
								</td>
								<td align="left">
								<a href="http://172.16.60.63:8080/interface/additional/management_office/request_for_quote/quotation_form_set/quotation_form_set.jsp" ></a>									
								</td>
								<td align="left">
								<a href="http://172.16.60.63:8080/interface/additional/management_office/request_for_quote/TAPPING_the_cost_of_set/TAPPING_the_cost_of_set.jsp" >TAPING成本设定</a>									
								</td>
							</TR>
							<TR>
								<td align="right">客户与等级设定：</td>
								<td align="left">
								<a href="http://172.16.60.63:8080/interface/additional/management_office/request_for_quote/quotation_form_set/quotation_form_set.jsp" ></a>									
								</td>
								<td align="left">
								<a href="http://172.16.60.63:8080/interface/additional/management_office/request_for_quote/quotation_form_set/quotation_form_set.jsp" ></a>									
								</td>
							</TR>
							<TR>
								<td align="right">毛利率设定：</td>
								<td align="left">
								<a href="http://172.16.60.63:8080/interface/additional/management_office/request_for_quote/quotation_form_set/quotation_form_set.jsp" ></a>									
								</td>
								<td align="left">
								<a href="http://172.16.60.63:8080/interface/additional/management_office/request_for_quote/gross_margin_nucleus_of_permissions/gross_margin_nucleus_of_permissions.jsp" >毛利率核决权限</a>									
								</td>
								<td align="left">
								<a href="http://172.16.60.63:8080/interface/additional/management_office/request_for_quote/gross_margin_appearance_standards/gross_margin_appearance_standards.jsp" >外形标准毛利率</a>									
								</td>
								<td align="left">
								<a href="http://172.16.60.63:8080/interface/additional/management_office/request_for_quote/gross_margin_range_nuclear_permissions/gross_margin_range_nuclear_permissions.jsp" >毛利率变动幅度核决权限</a>									
								</td>
								<td align="left">
								<a href="http://172.16.60.63:8080/interface/additional/management_office/request_for_quote/quotation_form_set/quotation_form_set.jsp" ></a>									
								</td>
							</TR>
							<TR>
								<td align="right">批量改变成本系数设定：</td>
								<td align="left">
								<a href="http://172.16.60.63:8080/interface/additional/management_office/request_for_quote/quotation_form_set/quotation_form_set.jsp" ></a>									
								</td>
							</TR>
							<TR>
								<td align="right">报价外形设定：</td>
								<td align="left">
								<a href="http://172.16.60.63:8080/interface/additional/management_office/request_for_quote/quotation_form_set/quotation_form_set.jsp" >报价外形设定</a>									
								</td>
							</TR>
							<TR>
								<td align="right">报价汇率设定：</td>
								<td align="left">
								<a href="http://172.16.60.63:8080/interface/additional/management_office/request_for_quote/offer_rate_set/offer_rate_set.jsp" >报价汇率设定</a>									
								</td>
							</TR>
							

							<TR>
								<td align="right">快速报价：</td>
								<td align="left">
									<a href="http://172.16.60.63:8080/interface/offer_pay_test/quotationBrowser.jsp" >快速报价</a>
								</td>
							</TR>
							<TR>
								<td align="right">报价清单：</td>
								<td align="left">
									<a href="http://172.16.60.63:8080/interface/offer_pay_test/costList.jsp" >报价清单</a>
								</td>
							</TR>
							<TR>
								<td align="right">成本稽核单：</td>
								<td align="left">
									<a href="http://172.16.60.63:8080/interface/additional/apply_cost/audit_cost_sheet/audit_cost_sheet.jsp" >成本稽核单</a>
								</td>
							</TR>
					</TABLE>
				</FORM>
			</td>
		</tr>
		<tr>
			<td height="10" colspan="3"></td>
		</tr>
	</table>
</body>
<SCRIPT language="javascript" defer="defer"
	src="/js/JSDateTime/WdatePicker_wev8.js"></script>
<SCRIPT language="javascript" defer="defer" src="/js/datetime_wev8.js"></script>
</html>