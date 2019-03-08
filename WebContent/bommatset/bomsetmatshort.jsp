<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.Connection,java.sql.DriverManager,java.sql.PreparedStatement,java.sql.ResultSet,weaver.general.Util"%>
<%@ page import="java.util.*" %>
<%@ page import="weaver.interfaces.workflow.util.BillUtil" %>
<jsp:useBean id="mysmt" class="weaver.conn.RecordSet"/>
<jsp:useBean id="bs" class="weaver.general.BaseBean"></jsp:useBean>
<%
    int requestid = Util.getIntValue(request.getParameter("requestid"),0);//请求id
    int workflowid = Util.getIntValue(request.getParameter("workflowid"),0);//流程id
    int formid = Util.getIntValue(request.getParameter("formid"),0);//表单id
    int isbill = Util.getIntValue(request.getParameter("isbill"),0);//表单类型，1单据，0表单
    int nodeid = Util.getIntValue(request.getParameter("nodeid"),0);//流程的节点id
	String applicant = BillUtil.getLabelId(formid,0,"applicant");//创建人
	
	String  subsection= BillUtil.getLabelId(formid,0,"factory");//分部
	int nodeidA1 = BillUtil.getNodeId(workflowid, "创建");
	String  mat_short_desc= BillUtil.getLabelId(formid,1,"mat_short_desc");//物料描述
	String  mat_a= BillUtil.getLabelId(formid,1,"mat_a");//A料
	String  mat_t= BillUtil.getLabelId(formid,1,"mat_t");//T料
	

%>
<script  type="text/javascript">


	var applicant = <%=applicant%>
	var subsection = <%=subsection%>
	var mat_short_desc = <%=mat_short_desc%>
	var mat_a = <%=mat_a%>
	var mat_t = <%=mat_t%>
	
<%if(nodeid == nodeidA1){%>

jQuery(function(){
	jQuery.ajax({
				url: "/interface/bommatset/get_role_id.jsp",
				data: {roleid: $("#field" + applicant).val()},
				cache: true,
				type: "post",
				dataType: "text",
				async: false,
				success: function (result) {
					result = jQuery.trim(result);
					if(result == "1")
					{//崇川
						$("#field" + subsection ).attr("value","0");
						$("#field" + subsection ).change();
						setCover(subsection);
					}
					if(result == "142")
					{//苏通121 teste   142 prod
						$("#field" + subsection ).attr("value","1");
						$("#field" + subsection ).change();
						setCover(subsection);
					}
					if(result == "101")
					{//合肥
						$("#field" + subsection ).attr("value","2");
						$("#field" + subsection ).change();
						setCover(subsection);
					}			
				}
			});

    jQuery("button[name=addbutton0]").click(function(){
		var id = jQuery("input[id*='field" + mat_short_desc + "_']").last().attr("id");
		var tmp = id.split("_");
		var idx = tmp[1];
		$("input[id^=field"+mat_short_desc+"_").bindPropertyChange(function(){
			jQuery.ajax({
				url: "/interface/bommatset/bomgetmat.jsp",
				data: {mat_short_desc : $("#field"+mat_short_desc+"_"+idx).val(), factory : $("#field" + subsection ).val()},
				cache: false,
				type: "post",
				dataType: "text",
				async: false,
				success: function (sb) {
					sb = jQuery.trim(sb);
					var ary1  = new Array();
					ary1 = sb.split(" ");
					$("#field"+mat_a+"_"+idx).val(ary1[0]);
					$("#field"+mat_t+"_"+idx).val(ary1[1]);
					
				}
			});                                                         
        });	

	  //控制主表的是否全部Close为否不可提交
	});


		$("input[id^=field"+ mat_short_desc +"_").bindPropertyChange(function(e){
			var lineNumber = e.id.slice(11);
			jQuery.ajax({
				url: "/interface/bommatset/bomgetmat.jsp",
				data: {mat_short_desc : $("#field"+ mat_short_desc +"_"+lineNumber).val(), factory : $("#field" + subsection ).val()},
				cache: false,
				type: "post",
				dataType: "text",
				async: false,
				success: function (sb) {
					sb = jQuery.trim(sb);
					var ary1  = new Array();
					ary1 = sb.split(" ");
					$("#field"+mat_a+"_"+lineNumber).val(ary1[0]);
					$("#field"+mat_t+"_"+lineNumber).val(ary1[1]);
					
				}
			});                                                         
        });	
  })
  

	
	
	function setCover(field) {
		var temp = field;
		var htmlShadow = '<div id="shadow_' + temp + '"></div>';
		jQuery("#field" + temp).before(htmlShadow);
		jQuery("#shadow_" + temp).css("z-index",100);
		jQuery("#shadow_" + temp).css("height",30);
		jQuery("#shadow_" + temp).css("width",55);
		jQuery("#shadow_" + temp).css("top",jQuery("#field" + temp).parent().parent().offset().top);
		jQuery("#shadow_" + temp).css("left",jQuery("#field" + temp).parent().parent().offset().left);
		jQuery("#shadow_" + temp).css("position","absolute");
		jQuery("#shadow_" + temp).css("opacity",0.5);
		jQuery("#shadow_" + temp).css("background","#FFFFFF");
	}
  

<%}%>
</script>