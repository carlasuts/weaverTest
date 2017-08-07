package weaver.interfaces.sap;


import weaver.general.GCONST;
import weaver.soa.workflow.request.Cell;
import weaver.soa.workflow.request.DetailTable;
import weaver.soa.workflow.request.MainTableInfo;
import weaver.soa.workflow.request.Property;
import weaver.soa.workflow.request.Row;


 public class test {
    public static void main(String[] args)  {
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
   	 Property[] propertyArray = new Property[9];
		 propertyArray[0] = new Property();
		 propertyArray[0].setName("MANDT");
		 propertyArray[0].setValue("800");
		 propertyArray[1] = new Property();
		 propertyArray[1].setName("HEADID");
		 propertyArray[1].setValue("1002");
		 propertyArray[2] = new Property();
		 propertyArray[2].setName("MATNR");
		 propertyArray[2].setValue("A104dsa32gds9999-1");
		 propertyArray[3] = new Property();
		 propertyArray[3].setName("KLART");
		 propertyArray[3].setValue("022");
		 propertyArray[4] = new Property();
		 propertyArray[4].setName("CLASS");
		 propertyArray[4].setValue("Z_FERT_BCH");
		 propertyArray[5] = new Property();
		 propertyArray[5].setName("IT_HEADID");
		 propertyArray[5].setValue("0");
		 propertyArray[6] = new Property();
		 propertyArray[6].setName("CHARACT");
		 propertyArray[6].setValue("");
		 propertyArray[7] = new Property();
		 propertyArray[7].setName("VALUE");
		 propertyArray[7].setValue("");
		 propertyArray[8] = new Property();
		 propertyArray[8].setName("ATFOR");
		 propertyArray[8].setValue("");
		 maintableinfo.setProperty(propertyArray);

   	
       DetailTable dt = new DetailTable();
       Row row1 = new Row();
       Cell cell = new Cell();
       cell.setName("PRODUCTMATERIALCODE2");
       cell.setValue("A104dsa32gds9999-1");


       row1.addCell(cell);

       dt.addRow(row1);

       String rid ="1111414";
       ZMMI05101 zm = new ZMMI05101();
       zm.zmmi05101insert(dt,maintableinfo,rid);
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
    
    

    public void testwlzsj(){
    	 MainTableInfo maintableinfo = new MainTableInfo();
    	 Property[] propertyArray = new Property[6];
		 propertyArray[0] = new Property();
		 propertyArray[0].setName("MANDT");
		 propertyArray[0].setValue("800");
		 propertyArray[1] = new Property();
		 propertyArray[1].setName("HEADID");
		 propertyArray[1].setValue("1002");
		 propertyArray[2] = new Property();
		 propertyArray[2].setName("MATNR");
		 propertyArray[2].setValue("A656MT6735VTPAZA-5");
		 propertyArray[3] = new Property();
		 propertyArray[3].setName("KLART");
		 propertyArray[3].setValue("022");
		 propertyArray[4] = new Property();
		 propertyArray[4].setName("CLASS");
		 propertyArray[4].setValue("Z_FERT_BCH");
		 propertyArray[5] = new Property();
		 propertyArray[5].setName("IT_HEADID");
		 propertyArray[5].setValue("0");
		 propertyArray[6] = new Property();
		 propertyArray[6].setName("CHARACT");
		 propertyArray[6].setValue("");
		 propertyArray[7] = new Property();
		 propertyArray[7].setName("VALUE");
		 propertyArray[7].setValue("");
		 propertyArray[8] = new Property();
		 propertyArray[8].setName("ATFOR");
		 propertyArray[8].setValue("");
		 maintableinfo.setProperty(propertyArray);

    	
        DetailTable dt = new DetailTable();
        Row row1 = new Row();
        Cell cell = new Cell();
        cell.setName("PRODUCTMATERIALCODE");
        cell.setValue("T656MT6735VTPAZA-5");


        row1.addCell(cell);

        dt.addRow(row1);
        
        ZMMI05101 zm = new ZMMI05101();
        String rid ="1111414";
        zm.zmmi05101insert(dt,maintableinfo,rid);
        
        GCONST.setServerName("ecology");

    } 
}
