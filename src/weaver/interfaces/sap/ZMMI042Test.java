package weaver.interfaces.sap;

import weaver.general.GCONST;
import weaver.interfaces.sap.ZMMI042;
import weaver.soa.workflow.request.Cell;
import weaver.soa.workflow.request.DetailTable;
import weaver.soa.workflow.request.MainTableInfo;
import weaver.soa.workflow.request.Property;
import weaver.soa.workflow.request.Row;

public class ZMMI042Test {
	public static void main(String[] args) {
		/* DetailTable dt = new DetailTable();
        Row row = new Row();
        Cell cell = new Cell();
        cell.setName("DIEMATERIALCODE");
        cell.setValue("B552A37N-26CT-CM-8");
        Cell cell2 = new Cell();
        cell2.setName("DIEMATERIADESCRIPTION");
        cell2.setValue("152-DA00N37A-7026CTG-GR-e3-CU");
        Cell cell3 = new Cell();
        cell3.setName("MATERIALGROUP");
        cell3.setValue("B156");
        row.addCell(cell);
        row.addCell(cell2);
        row.addCell(cell3);
        dt.addRow(row);
        ZMMI040 zm = new ZMMI040();
        zm.xp(dt); */
		 MainTableInfo maintableinfo = new MainTableInfo();
		 Property[] propertyArray = new Property[10];
		 propertyArray[0] = new Property();
		 propertyArray[0].setName("PRODUCTMATERIALCODE1");
		 propertyArray[0].setValue("A656MT6735VTPAZA-5");
		 propertyArray[1] = new Property();
		 propertyArray[1].setName("PLANT");
		 propertyArray[1].setValue("1010");
		 propertyArray[2] = new Property();
		 propertyArray[2].setName("STANDARDROUTER");
		 propertyArray[2].setValue("");
		 propertyArray[3] = new Property();
		 propertyArray[3].setName("ROUTERCODE");
		 propertyArray[3].setValue("");
		 propertyArray[4] = new Property();
		 propertyArray[4].setName("GROUPCOUNT");
		 propertyArray[4].setValue("");
		 propertyArray[5] = new Property();
		 propertyArray[5].setName("USAGE");
		 propertyArray[5].setValue("");
		 propertyArray[6] = new Property();
		 propertyArray[6].setName("STATUS");
		 propertyArray[6].setValue("");
		 propertyArray[7] = new Property();
		 propertyArray[7].setName("UNIT");
		 propertyArray[7].setValue("EA");
		 propertyArray[8] = new Property();
		 propertyArray[8].setName("DESCRIPTION");
		 propertyArray[8].setValue("卷盘品(测试控制吸湿)  V93000");
		 propertyArray[9] = new Property();
		 propertyArray[9].setName("SEQUENCE");
		 propertyArray[9].setValue("");
		 maintableinfo.setProperty(propertyArray);

		String rid = "1111414";
		// ZMMI051 zm = new ZMMI051();
		// zm.wlzsj(dt,maintableinfo,rid);
		ZMMI042INSERT zs = new ZMMI042INSERT();
		zs.zmmi042insert(maintableinfo, rid);
	  
	       
	}
	 /*
    public void testzsj(){
        DetailTable dt = new DetailTable();
        Row row = new Row();
        Cell cell = new Cell();
        cell.setName("PRODUCTMATERIALCODE");
        cell.setValue("T656MT6735VTPAZA-5");
        Cell cell2 = new Cell();
        cell2.setName("CUSTOMERMTRLDESCRIPTION");
        cell2.setValue("656-MT6735V/TPAZAC-H-ee-GR-TR-MAP-X-2");
        Cell cell3 = new Cell();
        cell3.setName("PRODUCETYPE");
        cell3.setValue("1");
        Cell  cell4 = new Cell();
        cell4.setName("FACTORY");
        cell4.setValue("ASSY");

        row.addCell(cell);
        row.addCell(cell2);
        row.addCell(cell3);
        row.addCell(cell4);
        dt.addRow(row);
        ZMMI040 zm = new ZMMI040();
        GCONST.setServerName("ecology");

    } */
	
}
