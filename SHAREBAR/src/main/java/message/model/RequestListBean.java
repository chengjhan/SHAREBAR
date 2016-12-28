package message.model;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "requestList", catalog = "test3", schema = "dbo")
public class RequestListBean implements Serializable{

	private static final long serialVersionUID = 1L;
	@Id
	private int item_id;
	@Id
	private int requester_id;
	private String status;
	private java.util.Date time;
	
	public int getItem_id() {
		return item_id;
	}
	public void setItem_id(int item_id) {
		this.item_id = item_id;
	}
	public int getRequester_id() {
		return requester_id;
	}
	public void setRequester_id(int requester_id) {
		this.requester_id = requester_id;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public java.util.Date getTime() {
		return time;
	}
	public void setTime(java.util.Date time) {
		this.time = time;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	@Override
	public String toString() {
		return "RequestListBean [item_id=" + item_id + ", requester_id=" + requester_id + ", status=" + status
				+ ", time=" + time + "]";
	}		
}
