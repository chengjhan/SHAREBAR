package administrator.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Table;
import javax.persistence.Id;

@Entity
@Table(name = "service_mail", catalog = "test3", schema = "dbo")  //資料庫表格
public class ServiceMailBean {
	@Id
	@GeneratedValue( strategy = GenerationType.IDENTITY )
	private int mail_id;
	private int member_id;
	private java.util.Date time;
	private String context;
	private java.util.Date reply_time;
	private String gm_reply_context;
	
	
	public int getMail_id() {
		return mail_id;
	}
	public void setMail_id(int mail_id) {
		this.mail_id = mail_id;
	}
	public int getMember_id() {
		return member_id;
	}
	public void setMember_id(int member_id) {
		this.member_id = member_id;
	}
	public java.util.Date getTime() {
		return time;
	}
	public void setTime(java.util.Date time) {
		this.time = time;
	}
	public String getContext() {
		return context;
	}
	public void setContext(String context) {
		this.context = context;
	}
	public java.util.Date getReply_time() {
		return reply_time;
	}
	public void setReply_time(java.util.Date reply_time) {
		this.reply_time = reply_time;
	}
	public String getGm_reply_context() {
		return gm_reply_context;
	}
	public void setGm_reply_context(String gm_reply_context) {
		this.gm_reply_context = gm_reply_context;
	}
	
	
	

	


	
	
}
