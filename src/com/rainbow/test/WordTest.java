package com.rainbow.test;

import com.jacob.activeX.ActiveXComponent;
import com.jacob.com.Dispatch;
import com.jacob.com.Variant;

public class WordTest {
	// word文档
	private static Dispatch doc;
	// word运行程序对象
	private ActiveXComponent word;
	// 所有word文档集合
	private Dispatch documents;
	// 选定的范围或插入点
	private Dispatch selection;

	public WordTest() throws Exception {
		if (word == null) {
			word = new ActiveXComponent("Word.Application");
			word.setProperty("Visible", new Variant(false)); // 不可见打开word
			word.setProperty("AutomationSecurity", new Variant(3)); // 禁用宏
		}
		if (documents == null)
			documents = word.getProperty("Documents").toDispatch();
	}

	/**
	 * 创建一个新的word文档
	 */
	public void createNewDocument() {
		doc = Dispatch.call(documents, "Add").toDispatch();
		selection = Dispatch.get(word, "Selection").toDispatch();
	}

	/**
	 * 打开一个已存在的文档
	 */
	public void openDocument(String docPath) {
		createNewDocument();
		doc = Dispatch.call(documents, "Open", docPath).toDispatch();
		selection = Dispatch.get(word, "Selection").toDispatch();
	}

	/**
	 * 获得指定的单元格里数据
	 * 
	 * @param tableIndex
	 * @param cellRowIdx
	 * @param cellColIdx
	 * @return
	 */
	public String getTxtFromCell(int tableIndex, int cellRowIdx, int cellColIdx) {
		// 所有表格
		Dispatch tables = Dispatch.get(doc, "Tables").toDispatch();
		// 要填充的表格
		Dispatch table = Dispatch.call(tables, "Item", new Variant(tableIndex)).toDispatch();
		Dispatch rows = Dispatch.call(table, "Rows").toDispatch();
		Dispatch columns = Dispatch.call(table, "Columns").toDispatch();
		Dispatch cell = Dispatch.call(table, "Cell", new Variant(cellRowIdx), new Variant(cellColIdx)).toDispatch();
		Dispatch Range = Dispatch.get(cell, "Range").toDispatch();
		System.out.println(Dispatch.get(Range, "Text").toString());
		Dispatch.call(cell, "Select");
		String ret = "";
		ret = Dispatch.get(selection, "Text").toString();
		ret = ret.substring(0, ret.length() - 2); // 去掉最后的回车符;
		return ret;
	}

	public void closeDocumentWithoutSave() {
		if (doc != null) {
			Dispatch.call(doc, "Close", new Variant(false));
			doc = null;
		}
	}

	/**
	 * 关闭全部应用
	 */
	public void close() {
		if (word != null) {
			Dispatch.call(word, "Quit");
			word = null;
		}
		selection = null;
		documents = null;
	}

	public static void main(String[] args) throws Exception {
		WordTest word = new WordTest();
		// 打开word
		word.openDocument("F:\\(25)FT1_MT6166V_AMB_PCU_H_SMT65419_V12.doc");
		// 所有表格
		Dispatch tables = Dispatch.get(doc, "Tables").toDispatch();
		int tablesCount = Dispatch.get(tables, "Count").toInt();
		System.out.println(tablesCount);
		// 关闭该文档
		word.closeDocumentWithoutSave();
		// 关闭word
		word.close();

	}
}