package administrator.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="report")
public class ReportBean {
	@Id
	@GeneratedValue( strategy = GenerationType.IDENTITY )
	private int report_id;
	private int reporting_member_id;
	private int reported_item_id;
	private java.util.Date time;
	private String context;
	

	
	public int getReport_id() {
		return report_id;
	}
	public void setReport_id(int report_id) {
		this.report_id = report_id;
	}
	public int getReporting_member_id() {
		return reporting_member_id;
	}
	public void setReporting_member_id(int reporting_member_id) {
		this.reporting_member_id = reporting_member_id;
	}
	public int getReported_item_id() {
		return reported_item_id;
	}
	public void setReported_item_id(int reported_item_id) {
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
	
	@Override
	public String toString() {
		return "Report_bean [report_id=" + report_id + ", reporting_member_id=" + reporting_member_id
				+ ", reported_item_id=" + reported_item_id + ", date=" + time + ", context=" + context + "]";
	}
}
