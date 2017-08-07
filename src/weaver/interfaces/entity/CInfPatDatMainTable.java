package weaver.interfaces.entity;

public class CInfPatDatMainTable {

	private String ProductMaterialCode;
	private String Plant;
	private String Usage;
	private String AlternativeBom;

	public String getProductMaterialCode() {
		return ProductMaterialCode;
	}

	public void setProductMaterialCode(String productMaterialCode) {
		ProductMaterialCode = productMaterialCode;
	}

	public String getPlant() {
		return Plant;
	}

	public void setPlant(String plant) {
		Plant = plant;
	}

	public String getUsage() {
		return Usage;
	}

	public void setUsage(String usage) {
		Usage = usage;
	}

	public String getAlternativeBom() {
		return AlternativeBom;
	}

	public void setAlternativeBom(String alternativeBom) {
		AlternativeBom = alternativeBom;
	}

}
