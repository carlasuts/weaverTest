package com.rainbow.test;

import com.jacob.activeX.ActiveXComponent;
import com.jacob.com.Dispatch;
import com.jacob.com.Variant;

public class WordTest1 {

	public static void main(String[] args) {
		Dispatch wordDoc = null;
		ActiveXComponent word = null;
		try {
			word = new ActiveXComponent("Word.Application");
			word.setProperty("Visible", new Variant(false));
			word.setProperty("AutomationSecurity", new Variant(3));
			Dispatch documents = word.getProperty("Documents").toDispatch();
			wordDoc = Dispatch.call(documents, "Open", "C:\\Users\\zong.yq\\Desktop\\(25)FT1_MT6166V_AMB_PCU_H_SMT65419_V12.docx").toDispatch();
			Dispatch tables = Dispatch.get(wordDoc, "Tables").toDispatch();
			Dispatch table = Dispatch.call(tables, "Item", new Variant(1)).toDispatch();
			Dispatch rows = Dispatch.get(table, "Rows").toDispatch();
			Dispatch cols = Dispatch.get(table, "Columns").toDispatch();
			Dispatch cell;
			Dispatch range;
			String data;
			for (int i = 2; i <= Dispatch.get(rows, "count").getInt(); i++) {
				cell = Dispatch.call(table, "Cell", i, 1).toDispatch();
				range = Dispatch.get(cell, "Range").toDispatch();
				data = Dispatch.get(range, "Text").getString();
				System.out.print(data.trim() + ",");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			Dispatch.call(wordDoc, "Close", new Variant(true));
			word.invoke("Quit", new Variant[0]);
		}

	}

}
