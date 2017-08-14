package weaver.interfaces.workflow.pojo.TestDepartment.programList;

import java.io.Serializable;
import java.util.Set;

public class ProductNameVerifyPojo implements Serializable{

	private static final long serialVersionUID = 1L;
	private boolean ok = false;
	private String msg = null;
	private Set<String> content = null;
	public boolean isOk() {
		return ok;
	}
	public void setOk(boolean ok) {
		this.ok = ok;
	}
	public String getMsg() {
		return msg;
	}
	public void setMsg(String msg) {
		this.msg = msg;
	}
	public Set<String> getContent() {
		return content;
	}
	public void setContent(Set<String> content) {
		this.content = content;
	}
}
