package message.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import com.google.gson.annotations.Expose;

import item.model.ItemBean;
import member.model.MemberBean;

@Entity
@Table(name = "messageContext", catalog = "test3", schema = "dbo")
public class MessageContextBean {
	@Id
	@GeneratedValue( strategy = GenerationType.IDENTITY )
	@Expose
	private int messageNo;
	@ManyToOne
	@JoinColumn(name = "item_id")
	@Expose
	private ItemBean itemBean;
//	private int item_id;
	@ManyToOne
	@JoinColumn(name = "member_id_speaker")
	@Expose
	private MemberBean memberBean_speaker;
//	private int member_id_speaker;
	@ManyToOne
	@JoinColumn(name = "member_id_listener")
	@Expose
	private MemberBean memberBean_listener;
//	private int member_id_listener;
	@Expose
	private java.util.Date time;
	@Expose
	private String context;
	@Expose
	private int readed;
	
	@Override
	public String toString() {
		return "MessageContextBean [messageNo=" + messageNo + ", itemBean=" + itemBean + ", memberBean_speaker="
				+ memberBean_speaker + ", memberBean_listener=" + memberBean_listener + ", time=" + time + ", context="
				+ context + ", readed=" + readed + "]";
	}

	public int getMessageNo() {
		return messageNo;
	}

	public void setMessageNo(int messageNo) {
		this.messageNo = messageNo;
	}

	public ItemBean getItemBean() {
		return itemBean;
	}

	public void setItemBean(ItemBean itemBean) {
		this.itemBean = itemBean;
	}

	public MemberBean getMemberBean_speaker() {
		return memberBean_speaker;
	}

	public void setMemberBean_speaker(MemberBean memberBean_speaker) {
		this.memberBean_speaker = memberBean_speaker;
	}

	public MemberBean getMemberBean_listener() {
		return memberBean_listener;
	}

	public void setMemberBean_listener(MemberBean memberBean_listener) {
		this.memberBean_listener = memberBean_listener;
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

	public int getReaded() {
		return readed;
	}

	public void setReaded(int readed) {
		this.readed = readed;
	}
	
}
