package weaver.interfaces.entity;

public class CInfFlwDatDetailTable {

	private String itemNo;
	private String OPERADD;
	private String OPERDEC;
	private String workCenterFk;
	private String UPH;

	public String getOPERADD() {
		return OPERADD;
	}

	public void setOPERADD(String oPERADD) {
		OPERADD = oPERADD;
	}

	public String getOPERDEC() {
		return OPERDEC;
	}

	public void setOPERDEC(String oPERDEC) {
		OPERDEC = oPERDEC;
	}

	public String getWorkCenterFk() {
		return workCenterFk;
	}

	public void setWorkCenterFk(String workCenterFk) {
		this.workCenterFk = workCenterFk;
	}

	public String getUPH() {
		return UPH;
	}

	public void setUPH(String uPH) {
		UPH = uPH;
	}

	public String getItemNo() {
		return itemNo;
	}

	public void setItemNo(String itemNo) {
		this.itemNo = itemNo;
	}

}
