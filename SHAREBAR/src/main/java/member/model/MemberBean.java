package member.model;

import java.util.HashSet;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.OrderBy;
import javax.persistence.Table;

import com.google.gson.annotations.Expose;

import administrator.model.ReportBean;
import followitem.model.FollowItemsBean;
import item.model.ItemBean;
import message.model.MessageContextBean;
import messageBoard.model.MessageBoardBean;
import relationship.model.RelationshipBean;

@Entity
@Table(name = "member2", catalog = "test3", schema = "dbo")
public class MemberBean {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int member_no;
	private String first_name;
	private String last_name;
	private String country;
	private String city;
	private String email;
	private String password;
	@Expose
	private String nickname;
	private String facebook;
	private String photo;
	private String description;
	private String activate_token;
	private int certification;
	private int block;
	private java.util.Date signdate;
	private java.util.Date blockdate;
	@OneToMany(cascade = CascadeType.REMOVE, fetch = FetchType.LAZY, mappedBy = "member_follow")
	@OrderBy("member_follow asc")
	private Set<RelationshipBean> member_follow_rel = new HashSet<RelationshipBean>();

	@OneToMany(cascade = CascadeType.REMOVE, fetch = FetchType.LAZY, mappedBy = "member_followed")
	@OrderBy("member_followed asc")
	private Set<RelationshipBean> member_followed_rel = new HashSet<RelationshipBean>();

	@OneToMany(cascade = CascadeType.REMOVE, fetch = FetchType.EAGER, mappedBy = "member_id")
	@OrderBy("post_date asc")
	private Set<ItemBean> member_items = new HashSet<ItemBean>();
	
	@OneToMany(cascade = CascadeType.REMOVE, fetch = FetchType.EAGER, mappedBy = "member_id")
	@OrderBy("following_item_id asc")
	private Set<FollowItemsBean> follow_items = new HashSet<FollowItemsBean>();
	
	//阿三的阿三的阿三的阿三的阿三的阿三的阿三的阿三的阿三的阿三的阿三的阿三的阿三的阿三的阿三的阿三的
	@OneToMany(cascade = CascadeType.REMOVE, fetch = FetchType.LAZY, mappedBy = "memberBean_speaker")
	@OrderBy("messageNo ASC")
	@Expose(serialize = false)
	private Set<MessageContextBean> messageContextBeans_speaker = new HashSet<MessageContextBean>();
	
	@OneToMany(cascade = CascadeType.REMOVE, fetch = FetchType.LAZY, mappedBy = "memberBean_listener")
	@OrderBy("messageNo ASC")
	@Expose(serialize = false)
	private Set<MessageContextBean> messageContextBeans_listener = new HashSet<MessageContextBean>();
	//阿三的阿三的阿三的阿三的阿三的阿三的阿三的阿三的阿三的阿三的阿三的阿三的阿三的阿三的阿三的阿三的	
	
	//新增留言板關聯 geter seter記得加
	@OneToMany(cascade=CascadeType.REMOVE, fetch = FetchType.EAGER, mappedBy="member_id")
	@OrderBy("id asc")
	private Set<MessageBoardBean> messageboard = new HashSet<MessageBoardBean>();
	
	//阿典新增
	@OneToMany(cascade = CascadeType.REMOVE, fetch = FetchType.EAGER, mappedBy = "reporting_member_id")
	private Set<ReportBean> reporting_member_id = new HashSet<ReportBean>();
	
	public int getMember_no() {
		return member_no;
	}

	public void setMember_no(int member_no) {
		this.member_no = member_no;
	}

	public String getFirst_name() {
		return first_name;
	}

	public void setFirst_name(String first_name) {
		this.first_name = first_name;
	}

	public String getLast_name() {
		return last_name;
	}

	public void setLast_name(String last_name) {
		this.last_name = last_name;
	}

	public String getCountry() {
		return country;
	}

	public void setCountry(String country) {
		this.country = country;
	}

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

	public String getFacebook() {
		return facebook;
	}

	public void setFacebook(String facebook) {
		this.facebook = facebook;
	}

	public String getPhoto() {
		return photo;
	}

	public void setPhoto(String photo) {
		this.photo = photo;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getActivate_token() {
		return activate_token;
	}

	public void setActivate_token(String activate_token) {
		this.activate_token = activate_token;
	}

	public int getCertification() {
		return certification;
	}

	public void setCertification(int certification) {
		this.certification = certification;
	}

	public int getBlock() {
		return block;
	}

	public void setBlock(int block) {
		this.block = block;
	}

	public java.util.Date getSigndate() {
		return signdate;
	}

	public void setSigndate(java.util.Date signdate) {
		this.signdate = signdate;
	}

	public java.util.Date getBlockdate() {
		return blockdate;
	}

	public void setBlockdate(java.util.Date blockdate) {
		this.blockdate = blockdate;
	}

	public Set<RelationshipBean> getMember_follow_rel() {
		return member_follow_rel;
	}

	public void setMember_follow_rel(Set<RelationshipBean> member_follow_rel) {
		this.member_follow_rel = member_follow_rel;
	}

	public Set<RelationshipBean> getMember_followed_rel() {
		return member_followed_rel;
	}

	public void setMember_followed_rel(Set<RelationshipBean> member_followed_rel) {
		this.member_followed_rel = member_followed_rel;
	}

	public Set<ItemBean> getMember_items() {
		return member_items;
	}

	public void setMember_items(Set<ItemBean> member_items) {
		this.member_items = member_items;
	}

	public Set<FollowItemsBean> getFollow_items() {
		return follow_items;
	}

	public void setFollow_items(Set<FollowItemsBean> follow_items) {
		this.follow_items = follow_items;
	}

	public Set<MessageContextBean> getMessageContextBeans_speaker() {
		return messageContextBeans_speaker;
	}

	public void setMessageContextBeans_speaker(Set<MessageContextBean> messageContextBeans_speaker) {
		this.messageContextBeans_speaker = messageContextBeans_speaker;
	}

	public Set<MessageContextBean> getMessageContextBeans_listener() {
		return messageContextBeans_listener;
	}

	public void setMessageContextBeans_listener(Set<MessageContextBean> messageContextBeans_listener) {
		this.messageContextBeans_listener = messageContextBeans_listener;
	}

	public Set<MessageBoardBean> getMessageboard() {
		return messageboard;
	}

	public void setMessageboard(Set<MessageBoardBean> messageboard) {
		this.messageboard = messageboard;
	}
}
