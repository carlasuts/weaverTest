package weaver.interfaces.sap;

import java.util.LinkedList;
import java.util.List;

public class Test1 {

	public static void main(String[] args) {
		String newlist = "";
		String str1 = "656-2PK907213AAM06TSUMV56RUUZ1-R-GReMAP1\r\n<br>656-2PK907213AAM06TSUMV56RUUZ1-R-GReMAP2\r\n<br>656-2PK907213AAM06TSUMV56RUUZ1-R-GReMAP3\r\n<br>656-2PK907213AAM06TSUMV56RUUZ1-R-GReMAP4\r\n<br>656-2PK907213AAM06TSUMV56RUUZ1-R-GReMAP5\r\n<br>656-2PK907213AAM06TSUMV56RUUZ1-R-GReMAP6";
		String str2 = "656-2PK907213AAM06TSUMV56RUUZ1-R-GReMAP1\r\n<br>656-2PK907213AAM06TSUMV56RUUZ1-R-GReMAP3\r\n<br>656-2PK907213AAM06TSUMV56RUUZ1-R-GReMAP5";
		String[] list1 = str1.split("\r\n<br>");
		String[] list2 = str2.split("\r\n<br>");
		List<String> list = new LinkedList<String>();
		for (String str3 : list1) {
			if (!list.contains(str3)) {
				list.add(str3);
			}
		}
		//System.out.println(list);
		for (String str4 : list2) {
			if (list.contains(str4)) {
				list.remove(str4);
			}
		}

		//System.out.println(list1.length);
		for (int i = 0; i < list.size(); i++) {
			if (i < list.size() - 1) {
				newlist = newlist + list.get(i) + "\r\n" + "<br>";
			} else if (i == list.size() - 1) {
				newlist = newlist + list.get(i);
			}
		}
		System.out.println(str1);
		//System.out.println(str2);
	}
}
