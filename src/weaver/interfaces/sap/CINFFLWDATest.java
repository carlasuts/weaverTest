package weaver.interfaces.sap;

import weaver.soa.workflow.request.Cell;
import weaver.soa.workflow.request.DetailTable;
import weaver.soa.workflow.request.MainTableInfo;
import weaver.soa.workflow.request.Property;
import weaver.soa.workflow.request.Row;

public class CINFFLWDATest {

	public static void main(String[] args) {
		MainTableInfo maintableinfo = new MainTableInfo();
		Property[] propertyArray = new Property[8];
		propertyArray[0] = new Property();
		propertyArray[0].setName("PRODUCTMATERIALCODE1");
		propertyArray[0].setValue("T656MT6735VTPAZA-5");
		propertyArray[1] = new Property();
		propertyArray[1].setName("PLANT");
		propertyArray[1].setValue("");
		propertyArray[2] = new Property();
		propertyArray[2].setName("ROUTERCODE");
		propertyArray[2].setValue("T656T3TB");
		propertyArray[3] = new Property();
		propertyArray[3].setName("GROUPCOUNT");
		propertyArray[3].setValue("01");
		propertyArray[4] = new Property();
		propertyArray[4].setName("SEQUENCE");
		propertyArray[4].setValue("000000");
		propertyArray[5] = new Property();
		propertyArray[5].setName("USAGE");
		propertyArray[5].setValue("1");
		propertyArray[6] = new Property();
		propertyArray[6].setName("UNIT");
		propertyArray[6].setValue("EA");
		propertyArray[7] = new Property();
		propertyArray[7].setName("DESCRIPTION");
		propertyArray[7].setValue("卷盘品(测试控制吸湿)  V93000");
		maintableinfo.setProperty(propertyArray);

		DetailTable dt = new DetailTable();
		Row row1 = new Row();
		Cell cell = new Cell();
		cell.setName("ITEMNO");
		cell.setValue("0010");
		Cell cell1 = new Cell();
		cell1.setName("OPER");
		cell1.setValue("6000");
		Cell cell2 = new Cell();
		cell2.setName("OPERDEC");
		cell2.setValue("TEST BANK");
		Cell cell3 = new Cell();
		cell3.setName("WORKCENTER");
		cell3.setValue("3ETEEE");
		Cell cell4 = new Cell();
		cell4.setName("UPH");
		cell4.setValue("999999");

		row1.addCell(cell);
		row1.addCell(cell1);
		row1.addCell(cell2);
		row1.addCell(cell3);
		row1.addCell(cell4);
		dt.addRow(row1);
		
		Row row2 = new Row();
		Cell cell5 = new Cell();
		cell5.setName("ITEMNO");
		cell5.setValue("");
		Cell cell6 = new Cell();
		cell6.setName("OPER");
		cell6.setValue("6001");
		Cell cell7 = new Cell();
		cell7.setName("OPERDEC");
		cell7.setValue("TEST BANK");
		Cell cell8 = new Cell();
		cell8.setName("WORKCENTER");
		cell8.setValue("3ETEEE");
		Cell cell9 = new Cell();
		cell9.setName("UPH");
		cell9.setValue("999999");

		row2.addCell(cell5);
		row2.addCell(cell6);
		row2.addCell(cell7);
		row2.addCell(cell8);
		row2.addCell(cell9);
		dt.addRow(row2);

		String rid = "1111414";
		CINFFLWDAT cs = new CINFFLWDAT();
		cs.setcinfflwdat(dt, maintableinfo, rid,"162806");

	}

}
