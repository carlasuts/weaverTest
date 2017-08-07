package weaver.interfaces.sap;

import weaver.interfaces.sap.test;
import weaver.soa.workflow.request.Cell;
import weaver.soa.workflow.request.DetailTable;
import weaver.soa.workflow.request.MainTableInfo;
import weaver.soa.workflow.request.Property;
import weaver.soa.workflow.request.Row;

public class TestSPE {

	public static void main(String args[]) {
		MainTableInfo maintableinfo = new MainTableInfo();
		Property[] propertyArray = new Property[4];
		propertyArray[0] = new Property();
		propertyArray[0].setName("PRODUCTMATERIALCODE");
		propertyArray[0].setValue("A656MT6735VTPAZA-5");
		propertyArray[1] = new Property();
		propertyArray[1].setName("FACTORY");
		propertyArray[1].setValue("ASSY");
		propertyArray[2] = new Property();
		propertyArray[2].setName("CUSTOMER");
		propertyArray[2].setValue("656");
		propertyArray[3] = new Property();
		propertyArray[3].setName("ASSYCUSTOMERMTRLCODE");
		propertyArray[3].setValue("ASSYCUSTOMERMTRLCODE");
		maintableinfo.setProperty(propertyArray);

		DetailTable dt = new DetailTable();
		Row row1 = new Row();
		Cell cell = new Cell();
		cell.setName("IDNRK");
		cell.setValue("R1030062SENJ000009");
		Cell cell2 = new Cell();
		cell2.setName("POSNR");
		cell2.setValue("50");
		Cell cell3 = new Cell();
		cell3.setName("ITEMNO");
		cell3.setValue("50");
		Cell cell4 = new Cell();
		cell4.setName("MENGE");
		cell4.setValue("0.750");
		Cell cell5 = new Cell();
		cell5.setName("MEINS");
		cell5.setValue("G");
		Cell cell6 = new Cell();
		cell6.setName("LGORT");
		cell6.setValue("1221");
		Cell cell7 = new Cell();
		cell7.setName("SANKA");
		cell7.setValue("X");

		Cell cell9 = new Cell();
		cell9.setName("AUSCH");
		cell9.setValue("0");
		Cell cell10 = new Cell();
		cell10.setName("ALPGR");
		cell10.setValue("1");
		Cell cell11 = new Cell();
		cell11.setName("ALPRF");
		cell11.setValue("1");
		Cell cell12 = new Cell();
		cell12.setName("ALPST");
		cell12.setValue("2");
		row1.addCell(cell);
		row1.addCell(cell2);
		row1.addCell(cell3);
		row1.addCell(cell4);
		row1.addCell(cell5);
		row1.addCell(cell6);
		row1.addCell(cell7);
		row1.addCell(cell9);
		row1.addCell(cell10);
		row1.addCell(cell11);
		row1.addCell(cell12);
		dt.addRow(row1);

		CINFSPEDAT cinf = new CINFSPEDAT();
		cinf.insert(dt, "200", maintableinfo, "test");
	}
}
