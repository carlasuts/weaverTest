package weaver.interfaces.schedule;

import java.util.*;
import java.text.*;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.math.*;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.Multipart;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import javax.mail.internet.MimeUtility;

import jxl.Workbook;
import jxl.write.Label;
import jxl.write.WritableSheet;
import jxl.write.WritableWorkbook;
import jxl.write.WriteException;
import weaver.conn.*;
import weaver.general.TimeUtil;
import weaver.general.Util;
import weaver.interfaces.workflow.action.Action;
import weaver.soa.workflow.request.*;
import weaver.general.BaseBean;

public class tecdrme02 extends BaseCronJob {
	public tecdrme02() {
	}

	public void execute() {
		BaseBean bs = new BaseBean();
		try {
			String filename = "������ͼֽ����";
			filename = new String(filename.getBytes("gbk"),"gbk");
			Date d = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
			String date = sdf.format(d);
			this.createExcel(path+filename+date+".xls");
			Workbook rwb = jxl.Workbook.getWorkbook(new File(path+filename+date+".xls"));
	        jxl.Sheet rs = rwb.getSheet(0);
	        int rsRows = rs.getRows();
	        if(rsRows > 1){
	        	this.send_email("shi.xc@tfme.com", "����ͼֽ����", null, path+filename+date+".xls");
	        }else{
	        	this.send_email("shi.xc@tfme.com", "����ͼֽ����", "����û���µ�ͼֽ������������", null);
	        }
			
			//this.deleteFile("d:/temp/test1.xls");
		} catch (Exception e) {
			bs.writeLog("tecdrme02:" + e);
		}  
	}

	private String server = "172.16.2.32";
	private String user = "sub\\oainfo";
	private String password = "Tfmeoa2017";
	private static String path = "d:/������ͼֽ����/";
	
	/*
	public void deleteFile(String fileName) {
        File file = new File(fileName);
        // ����ļ�·������Ӧ���ļ����ڣ�������һ���ļ�����ֱ��ɾ��
        if (file.exists() && file.isFile()) {
            if (file.delete()) {
                System.out.println("ɾ�������ļ�" + fileName + "�ɹ���");
            } else {
                System.out.println("ɾ�������ļ�" + fileName + "ʧ�ܣ�");
            }
        } else {
            System.out.println("ɾ�������ļ�ʧ�ܣ�" + fileName + "�����ڣ�");
        }
    }
	*/
	
	public void send_email(String emailAddressesInString, String subject,
			String body, String filePath) throws Exception {
		Properties props = new Properties();
		props.put("mail.smtp.host", server);
		props.put("mail.from", "oainfo@tfme.com");
		props.put("mail.smtp.auth", "true");

		// Session session = Session.getInstance(props);
		Session session = Session.getDefaultInstance(props,
				new MyAuthenricator(user, password));
		session.setDebug(true);
		MimeMessage msg = new MimeMessage(session);
		msg.setFrom();
		msg.setSentDate(new Date());

		Transport transport;
		transport = session.getTransport("smtp");

		// transport.connect(server, user, password);
		transport.connect();

		System.out.println("hi");

		msg.setRecipients(Message.RecipientType.TO,
				getRightEmailAddresses(emailAddressesInString));
		msg.setSubject(subject, "UTF-8");
		msg.setText(body, "UTF-8");
 
		MimeBodyPart mbp2 = new MimeBodyPart();
		mbp2.attachFile(filePath);
		mbp2.setFileName(MimeUtility.encodeWord(filePath.substring(filePath.lastIndexOf("/") + 1)));
		Multipart mp = new MimeMultipart();
		mp.addBodyPart(mbp2);

		msg.setContent(mp);

		msg.saveChanges();
		transport.sendMessage(msg, msg.getAllRecipients());
		transport.close();
	}

	private static class MyAuthenricator extends Authenticator {
		String user = null;
		String pass = "";

		public MyAuthenricator(String user, String pass) {
			this.user = user;
			this.pass = pass;
		}

		@Override
		protected PasswordAuthentication getPasswordAuthentication() {
			return new PasswordAuthentication(user, pass);
		}

	}

	private static InternetAddress[] getRightEmailAddresses(
			String emailAddressesInString) {
		String[] emailAddresses = emailAddressesInString.split(";");
		List<InternetAddress> emailTempList = new ArrayList<InternetAddress>();
		int realListSize = 0;
		InternetAddress[] temp = null;
		for (int i = 0; i < emailAddresses.length; i++) {
			try {
				temp = InternetAddress.parse(emailAddresses[i]);
			} catch (Exception e) {
				System.out.println("[E] emailAddresses:[parse]\t"
						+ emailAddresses[i]);
				continue;
			}
			if (temp.length != 1) {
				continue;
			} else {
				try {
					emailTempList.add(new InternetAddress(emailAddresses[i]));
				} catch (AddressException e) {
					System.err.println("Error at emailTempList");
					e.printStackTrace();
				}
				realListSize++;
			}
		}
		InternetAddress[] rightToAddress = null;
		if (realListSize < 1) {
			System.err.println("Nothing Right");
			return null;
		} else {
			rightToAddress = new InternetAddress[realListSize];
			for (int i = 0; i < realListSize; i++) {
				rightToAddress[i] = emailTempList.get(i);
			}
		}
		return rightToAddress;
	}

	public void createExcel(String filePath) throws WriteException, IOException {
		FileOutputStream os = new FileOutputStream(filePath);
		// ����������
		WritableWorkbook workbook = Workbook.createWorkbook(os);
		// �����µ�һҳ
		WritableSheet sheet = workbook.createSheet("First Sheet", 0);
		// ����Ҫ��ʾ������,����һ����Ԫ�񣬵�һ������Ϊ�����꣬�ڶ�������Ϊ�����꣬����������Ϊ����
		Label tzbh = new Label(0, 0, "ͼֽ���");
		sheet.addCell(tzbh);
		Label tzbb = new Label(1, 0, "ͼֽ�汾");
		sheet.addCell(tzbb);
		Label pkg = new Label(2, 0, "��װ����");
		sheet.addCell(pkg);
		Label pkld = new Label(3, 0, "��װ����");
		sheet.addCell(pkld);
		Label custid = new Label(4, 0, "�ͻ���");
		sheet.addCell(custid);
		Label cppm = new Label(5, 0, "Ʒ������");
		sheet.addCell(cppm);
		Label khpm = new Label(6, 0, "�ͻ�Ʒ��");
		sheet.addCell(khpm);
		Label gcname = new Label(7, 0, "����");
		sheet.addCell(gcname);
		Label tzlxname = new Label(8, 0, "ͼֽ����");
		sheet.addCell(tzlxname);
		Label diename = new Label(9, 0, "оƬ����");
		sheet.addCell(diename);

		Date d = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		String date = sdf.format(d);

		String sql = "";
		RecordSet rs = new RecordSet();
		sql = "select * from otecdrmedef where create_time =  " + date ;
		rs.executeSql(sql);
		int i = 1;
		while (rs.next()) {
			Label tzbh1 = new Label(0, i, rs.getString("tzbh"));
			sheet.addCell(tzbh1);
			Label tzbb1 = new Label(1, i, rs.getString("tzbb"));
			sheet.addCell(tzbb1);
			Label pkg1 = new Label(2, i, rs.getString("pkg"));
			sheet.addCell(pkg1);
			Label pkld1 = new Label(3, i, rs.getString("pkld"));
			sheet.addCell(pkld1);
			Label custid1 = new Label(4, i, rs.getString("custid"));
			sheet.addCell(custid1);
			Label cppm1 = new Label(5, i, rs.getString("matdesc"));
			sheet.addCell(cppm1);
			Label khpm1 = new Label(6, i, rs.getString("khpm"));
			sheet.addCell(khpm1);
			Label gcname1 = new Label(7, i, rs.getString("gcname"));
			sheet.addCell(gcname1);
			Label tzlxname1 = new Label(8, i, rs.getString("tzlxname"));
			sheet.addCell(tzlxname1);
			Label diename1 = new Label(8, i, rs.getString("diename"));
			sheet.addCell(diename1);
			i++;
		}
		// �Ѵ���������д�뵽������У����ر������
		workbook.write();
		workbook.close();
		os.close();
	}
}
