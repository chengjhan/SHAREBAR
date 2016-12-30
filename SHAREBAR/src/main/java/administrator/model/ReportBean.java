package administrator.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import item.model.ItemBean;
import member.model.MemberBean;

@Entity
@Table(name="report")
public class ReportBean {
	@Id
	@GeneratedValue( strategy = GenerationType.IDENTITY )
	private int report_id;
	@ManyToOne
	@JoinColumn(name = "reporting_member_id")
	private MemberBean reporting_member_id;	
	@ManyToOne
	@JoinColumn(name = "reported_item_id")
	private ItemBean reported_item_id;	
	private java.util.Date time;
	private String context;
	
	
	public int getReport_id() {
		return report_id;
	}
	public void setReport_id(int report_id) {
		this.report_id = report_id;
	}
	public MemberBean getReporting_member_id() {
		return reporting_member_id;
	}
	public void setReporting_member_id(MemberBean reporting_member_id) {
		this.reporting_member_id = reporting_member_id;
	}
	public ItemBean getReported_item_id() {
		return reported_item_id;
	}
	public void setReported_item_id(ItemBean reported_item_id) {
		this.reported_item_id = reported_item_id;
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
	

	
	
}
