package weaver.interfaces.workflow.action.testDepartment.programList;
import java.io.FileInputStream;
import java.util.Iterator;
import java.util.List;
import org.apache.poi.hwpf.HWPFDocument;
import org.apache.poi.hwpf.usermodel.Paragraph;
import org.apache.poi.hwpf.usermodel.Range;
import org.apache.poi.hwpf.usermodel.Table;
import org.apache.poi.hwpf.usermodel.TableCell;
import org.apache.poi.hwpf.usermodel.TableIterator;
import org.apache.poi.hwpf.usermodel.TableRow;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;
import org.apache.poi.xwpf.usermodel.XWPFDocument;
import org.apache.poi.xwpf.usermodel.XWPFTable;
import org.apache.poi.xwpf.usermodel.XWPFTableCell;
import org.apache.poi.xwpf.usermodel.XWPFTableRow;

public class ExportDocImpl {
	public static void main(String[] args) {
		ExportDocImpl test = new ExportDocImpl();
		// String filePath="E:\\java导入word表格.doc";
		String filePath = "F:\\2003.docx";
		test.testWord(filePath);
	}

	public void testWord(String filePath) {
		try {
			FileInputStream in = new FileInputStream(filePath);// 载入文档
			// 如果是office2007 docx格式
			if (filePath.toLowerCase().endsWith("docx")) {
				XWPFDocument xwpf = new XWPFDocument(in);// 得到word文档的信�?
				Iterator<XWPFTable> it = xwpf.getTablesIterator();// 得到word中的表格
				if (it.hasNext()) {
					XWPFTable table = it.next();
					List<XWPFTableRow> rows = table.getRows();
					// 读取每一行数�?
					for (int i = 1; i < rows.size(); i++) {
						XWPFTableRow row = rows.get(i);
						// 读取每一列数�?
						List<XWPFTableCell> cells = row.getTableCells();
							XWPFTableCell cell = cells.get(0);
							// 输出当前的单元格的数�?
							System.out.println(cell.getText());
					}

				}
			} else {
				// 如果是office2003 doc格式
				POIFSFileSystem pfs = new POIFSFileSystem(in);
				HWPFDocument hwpf = new HWPFDocument(pfs);
				Range range = hwpf.getRange();// 得到文档的读取范�?
				TableIterator it = new TableIterator(range);
				// 迭代文档中的表格
				if (it.hasNext()) {
					Table tb = (Table) it.next();
					// 迭代行，默认�?�?��
					for (int i = 1; i < tb.numRows(); i++) {
						TableRow tr = tb.getRow(i);
						TableCell td = tr.getCell(0);// 取得单元�?
						// 取得单元格的内容
						for (int k = 0; k < td.numParagraphs(); k++) {
							Paragraph para = td.getParagraph(k);
							String s = para.text();
							// 去除后面的特殊符�?
							if (null != s && !"".equals(s)) {
								s = s.substring(0, s.length() - 1);
							}
							System.out.println(s);
						}
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

}
