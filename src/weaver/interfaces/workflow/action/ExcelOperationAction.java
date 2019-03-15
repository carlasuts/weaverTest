package weaver.interfaces.workflow.action;

import org.apache.poi.hssf.usermodel.*;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;
import org.json.JSONObject;
import weaver.conn.RecordSet;
import weaver.general.BaseBean;
import weaver.interfaces.workflow.util.ZipUtil;
import weaver.soa.workflow.request.RequestInfo;

import java.io.*;
import java.text.DecimalFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

import static weaver.interfaces.workflow.action.quotation.DataToC4C.*;

/**
 * @author zong.yq
 * TODO: 节点后负责读取上传的附件 如果此流程单涉及到退回 则先删除CRM中已经触发的预约申请单，然后在重新创建
 */
public class ExcelOperationAction implements Action {
    private static BaseBean baseBean = new BaseBean();
    private static RecordSet rs = new RecordSet();
    private static final String USERNAME = "OAUser";
    private static final String PASSWORD = "OAUser";
    private static final String URL = "https://my500472.c4c.saphybriscloud.cn/sap/c4c/odata/v1/c4codataapi/AppointmentCollection";
    /**
     * 前缀
     */
    private static final String PREFIX = "https://my500472.c4c.saphybriscloud.cn/sap/c4c/odata/v1/c4codataapi/EmployeeCollection?$filter=EmployeeID%20eq%20'";
    /**
     * 后缀
     */
    private static final String POSTFIX = "'";
    private static final String PREFIX1 = "https://my500472.c4c.saphybriscloud.cn/sap/c4c/odata/v1/c4codataapi/";
//    private static final String POSTFIX1 = "?$format=json";
    private String sql = "";

    @Override
    public String execute(RequestInfo request) {
        baseBean.writeLog("ExcelOperationAction Start Running!");
        String requestId = request.getRequestid();
        int formId = Math.abs(request.getRequestManager().getFormid());
        // 申请人
        String applicant = "";
        // CRM返回给OA的申请单的ID
        String tagValue = "";
        String filePath = fileOperating(requestId, formId);
        File file = new File(filePath);
        // 获取流程中的数据
        sql = "SELECT * FROM FORMTABLE_MAIN_" + formId + " WHERE REQUESTID = '" + requestId + "'";
        rs.executeSql(sql);
        if (rs.next()) {
            applicant = rs.getString("REQMAN");
            tagValue = rs.getString("TAG_VALUE");
        }
        // 判断tagValue字段是否为空 如果不为空 则说明此流程为退回流程 则先删掉已触发的CRM中的申请单
        if (!"".equals(tagValue)) {
            baseBean.writeLog("此流程已在CRM中创建过差旅事前申请单, tagValue值为: " + tagValue);
            delete(tagValue);
        }
        String businessPartnerId =  getCreatorBp(applicant);
        baseBean.writeLog("当前申请人的BP编号: " + businessPartnerId);
        try {
            String[][] result = getData(file, 1);
            int rowLength = result.length;
            List<String> list = new ArrayList<String>(rowLength);
            for (int i = 0; i < rowLength; i++) {
                String cust = "", startTime = "", endTime = "", project = "", partner = "", participant = "", location = "";
                Map<Integer, String> map = new HashMap<Integer, String>(result[i].length);
                for (int j = 0; j < result[i].length; j ++) {
                    map.put(j, result[i][j]);
                }
                for (Map.Entry<Integer, String> entry : map.entrySet()) {
                    baseBean.writeLog("key = " + entry.getKey() + " and value = " + entry.getValue());
                    switch (entry.getKey()) {
                        case 0:
                            cust = entry.getValue();
                            break;
                        case 1:
                            startTime = entry.getValue();
                            break;
                        case 2:
                            endTime = entry.getValue();
                            break;
                        case 3:
                            project = entry.getValue();
                            break;
                        case 4:
                            partner = entry.getValue();
                            break;
                        case 5:
                            participant = entry.getValue();
                            break;
                        case 6:
                            location = entry.getValue();
                        default:
                            break;
                    }
                }
                // 生成json对象
                JSONObject req = createJson(businessPartnerId, cust, startTime, endTime, project, partner, participant, location);
                baseBean.writeLog("req: " + req.toString());
                tagValue = doCreate(req);
                list.add(tagValue);
            }
            updateTagValue(list, requestId, formId);
        } catch (IOException e) {
            e.printStackTrace();
        }
        deleteUnzipFile(filePath);
        return Action.SUCCESS;
    }

    /**
     * 获取创建人在CRM系统中的BP编号
     * @param applicant 申请人OA系统中的ID
     * @return
     */
    private String getCreatorBp (String applicant) {
        sql = "SELECT WORKCODE FROM HRMRESOURCE WHERE ID = '" + applicant + "'";
        rs.executeSql(sql);
        rs.next();
        String employeeId = rs.getString("WORKCODE");
        /**
         * 通过OA中的workCode获取CRM中的BP编号的URL
         * 例如： https://my500472.c4c.saphybriscloud.cn/sap/c4c/odata/v1/c4codataapi/EmployeeCollection?$filter=EmployeeID%20eq%20'171503'
         */
        String employeeUrl = PREFIX + employeeId + POSTFIX;
        // 获取BP编号
        String businessPartnerId = doGetBP(employeeUrl, USERNAME, PASSWORD, employeeId);
        return businessPartnerId;
    }

    /**
     * 创建一条JSON对象
     * @param businessPartnerID 申请人在CRM系统的BP编号
     * @param cust 客户号
     * @param startTime 开始时间
     * @param endTime 结束时间
     * @param project 主题
     * @param partner 同行人
     * @param participant 参与人
     * @param location 地点
     * @return
     */
    private JSONObject createJson (String businessPartnerID, String cust, String startTime, String endTime, String project, String partner, String participant, String location) {
        // 先将时间转换成毫秒
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        Date startDate = null;
        Date endDate = null;
        try {
            startDate = sdf.parse(startTime);
            startTime = String.valueOf(startDate.getTime());
            endDate = sdf.parse(endTime);
            endTime = String.valueOf(endDate.getTime());
        } catch (ParseException e) {
            e.printStackTrace();
        }
        JSONObject req = new JSONObject();
        try {
            req.put("MainAccountPartyID", cust);
            req.put("StartDate", "/Date(" + startTime + ")/");
            req.put("EndDate", "/Date(" + endTime + ")/");
            req.put("Subject", project);
            req.put("canyuzhe", partner);
            req.put("Zkehucanyuzhe", participant);
            req.put("OwnerPartyID", businessPartnerID);
            req.put("DocumentType", "0001");
            req.put("Category", "0001");
            req.put("Location", location);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return req;
    }

    /**
     * 退回时执行的更新操作
     * @param tagValue
     */
//    private void doUpdate (String tagValue) {
//        String url = PREFIX1 + tagValue + POSTFIX1;
//        String token = doGet(url, USERNAME, PASSWORD);
//        baseBean.writeLog("当前获取单子的token为: " + token);
//        // 要更新的差旅事前申请单地址
//        url = PREFIX1 + tagValue;
//        baseBean.writeLog("需要更新的地址为: " + url);
////        int code = doPatch(token);
//    }

    /**
     * 此方法用于创建CRM中差旅事前申请单
     * 首先通过doGetBP获取申请在CRM中的BP编号，再创建申请单
     * @param req 向CRM中发送的json数据
     */
    private String doCreate (JSONObject req) {
        RequestInfo request = new RequestInfo();
        // 首先获取token 相当于一个密码
        String token = doGet(URL, USERNAME, PASSWORD);
        String tagValue = doPost(token, req, URL, USERNAME, PASSWORD);
        baseBean.writeLog("当前返回tagValue的值为: " + tagValue);
        if (!"".equals(tagValue)) {
            tagValue = tagValue.replace("'", "''");
        } else {
            request.getRequestManager().setMessageid("Exception");
            request.getRequestManager().setMessagecontent("创建失败，请联系管理员");
        }
        return tagValue;
    }

    /**
     * 删除此流程已经在CRM中申请的单子
     * @param tagValue CRM返回给OA的所有的申请ID
     */
    private void delete (String tagValue) {
        RequestInfo request = new RequestInfo();
        String[] tagValues = tagValue.split(",");
        String token = doGet(URL, USERNAME, PASSWORD);
        for (String newTagValue : tagValues) {
            String url = PREFIX1 + newTagValue.trim();
            baseBean.writeLog("url为: " + url);
            int code = doDelete(token, url, USERNAME, PASSWORD);
            baseBean.writeLog(code);
            if (code == 204) {
                baseBean.writeLog("删除成功");
            } else {
                request.getRequestManager().setMessageid("Exception");
                request.getRequestManager().setMessagecontent("删除失败，请联系管理员");
            }
        }
    }

    /**
     * 更新OA系统中的tagValue值
     * @param list 因为附件中可能会存在多条记录，CRM返回的tagValue也是多条，因而需要把所有的tagValue拼接起来存储
     * @param requestId OA生成的请求ID
     * @param formId 此流程的主表ID
     */
    private void updateTagValue (List<String> list, String requestId, int formId) {
        String tagValue = list.toString().replace("[","").replace("]","");
        sql = "UPDATE FORMTABLE_MAIN_" + formId + " SET TAG_VALUE = '" + tagValue + "' WHERE REQUESTID = '" + requestId + "'";
        rs.executeSql(sql);
    }

    /**
     * 附件上传到服务器后，找到附件在服务器上真实地址，解压后恢复文件原本的文件格式，便于后续读取文件的内容
     * @param requestId 请求ID
     * @param formId 表单ID
     * @return finalFilePath 此地址为附件带后缀的真实地址
     */
    private String fileOperating (String requestId, int formId) {
        String travelPlan = "";
        sql = "SELECT TRAVEL_PLAN FROM FORMTABLE_MAIN_" + formId + " WHERE REQUESTID = '" + requestId + "'";
        rs.executeSql(sql);
        if (rs.next()) {
            travelPlan = rs.getString("TRAVEL_PLAN");
        }
        String imageFileId = "", imageFileName = "", fileType = "";
        sql = "SELECT IMAGEFILEID, IMAGEFILENAME FROM DOCIMAGEFILE WHERE DOCID = '" + travelPlan + "'";
        rs.executeSql(sql);
        if (rs.next()) {
            imageFileId = rs.getString("IMAGEFILEID");
            // 文件名
            imageFileName = rs.getString("IMAGEFILENAME");
        }
        // 文件类型
        fileType = imageFileName.substring(imageFileName.indexOf('.'));
        String fileRealPath = "";
        sql = "SELECT FILEREALPATH FROM IMAGEFILE WHERE IMAGEFILEID = '" + imageFileId + "'";
        rs.executeSql(sql);
        if (rs.next()) {
            // 附件真实路路径
            fileRealPath = rs.getString("FILEREALPATH");
        }
        // 解压操作
        ZipUtil.unzip(fileRealPath);
        // 解压的文件的真实路径
        String unzipFileRealPath = fileRealPath.replace(".zip", "");
        // 最终文件带后缀路径
        String finalFilePath = unzipFileRealPath + fileType;
        // 创建一个文件
        File file = new File(unzipFileRealPath);
        if (file.exists()) {
            file.renameTo(new File(finalFilePath));
        }
        return finalFilePath;
    }

    /**
     * 获取文件中的所有值
     * @param file 需要处理的文件
     * @param ignoreRows 不要处理的行
     * @return returnArray 返回值
     * @throws FileNotFoundException
     * @throws IOException
     */
    private static String[][] getData (File file, int ignoreRows) throws FileNotFoundException, IOException {
        List<String[]> result = new ArrayList<String[]>();
        int rowSize = 0;
        BufferedInputStream in = new BufferedInputStream(new FileInputStream(file));
        // 打开HSSFWorkbook
        POIFSFileSystem fs = new POIFSFileSystem(in);
        HSSFWorkbook wb = new HSSFWorkbook(fs);
        HSSFCell cell = null;
        // 遍历Excel文件中的所有工作表
        for (int sheetIndex = 0; sheetIndex < wb.getNumberOfSheets(); sheetIndex++) {
            HSSFSheet st = wb.getSheetAt(sheetIndex);
            // 遍历每个工作表中的行，通常第一行为标题栏，一般不用取
            for (int rowIndex = ignoreRows; rowIndex <= st.getLastRowNum(); rowIndex++) {
                HSSFRow row = st.getRow(rowIndex);
                // 此行为空
                if (null == row) {
                    continue;
                }
                int tempRowSize = row.getLastCellNum();
                if (tempRowSize > rowSize) {
                    rowSize = tempRowSize;
                }
                String[] values = new String[rowSize];
                // 将values数组中填充五个空值
                Arrays.fill(values, "");
                boolean hasValue = false;
                for (short columnIndex = 0; columnIndex < row.getLastCellNum(); columnIndex++) {
                    String value = "";
                    cell = row.getCell(columnIndex);
                    if (null != cell) {
                        value = judgeCell(cell);
                    }
                    if (columnIndex == 0 && "".equals(value.trim())) {
                        break;
                    }
                    values[columnIndex] = rightTrim(value);
                    hasValue = true;
                }
                if (hasValue) {
                    result.add(values);
                }
            }
        }
        in.close();
        String[][] returnArray = new String[result.size()][rowSize];
        for (int i = 0; i < returnArray.length; i++) {
            returnArray[i] = (String[]) result.get(i);
        }
        return returnArray;
    }

    /**
     * 设置单元格的参数
     * @param cell 需要处理的单元格
     * @return value 返回值
     */
    private static String judgeCell (HSSFCell cell) {
        String value = "";
        Date date = null;
        // 注意:一定要设置成这样，否则就会出现乱码的情况
        cell.setEncoding(HSSFCell.ENCODING_UTF_16);
        switch (cell.getCellType()) {
            case HSSFCell.CELL_TYPE_STRING:
                value = cell.getStringCellValue();
                break;
            case HSSFCell.CELL_TYPE_NUMERIC:
                // 判断是否为日期格式
                if (HSSFDateUtil.isCellDateFormatted(cell)) {
                    date = cell.getDateCellValue();
                    // 如果单元格中的数值小于1，则为时间；如果大于1，则为日期
                    if (cell.getNumericCellValue() < 1) {
                        if (null != date) {
                            value = new SimpleDateFormat("HH:mm:ss").format(date);
                        } else {
                            value = "";
                        }
                    } else {
                        if (null != date) {
                            value = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(date);
                        } else {
                            value = "";
                        }
                    }
                } else {
                    value = new DecimalFormat("0").format(cell.getNumericCellValue());
                }
                break;
            case HSSFCell.CELL_TYPE_FORMULA:
                // 导入时如果以公式生成的数据则无值
                if (!"".equals(cell.getStringCellValue())) {
                    value = cell.getStringCellValue();
                } else {
                    value = cell.getNumericCellValue() + "";
                }
                break;
            case HSSFCell.CELL_TYPE_BLANK:
                break;
            case HSSFCell.CELL_TYPE_ERROR:
                break;
            case HSSFCell.CELL_TYPE_BOOLEAN:
                value = (cell.getBooleanCellValue() ? "Y" : "N");
                break;
            default:
        }
        return value;
    }

    /**
     * 去掉字符串右边的空格
     * @param str 要处理的字符串
     * @return 处理后的字符串
     */
    private static String rightTrim (String str) {
        if (null == str) {
            return "";
        }
        int length = str.length();
        for (int i = length -1; i >= 0; i--) {
            if (str.charAt(i) != 0x20) {
                break;
            }
            length--;
        }
        return str.substring(0, length);
    }

    /**
     * 删除文件操作
     * @param filePath
     */
    private static void deleteUnzipFile (String filePath) {
        baseBean.writeLog("准备删除解压缩后的文件");
        File file = new File(filePath);
        file.delete();
        baseBean.writeLog("文件删除成功");
    }
}
