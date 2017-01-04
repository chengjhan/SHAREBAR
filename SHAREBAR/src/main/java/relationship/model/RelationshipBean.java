package relationship.model;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import member.model.MemberBean;

@Entity
@Table(name = "relationship2", catalog = "test3", schema = "dbo")
public class RelationshipBean implements Serializable{
	@Id
	@ManyToOne
	@JoinColumn(name = "member_follow")
	private MemberBean member_follow;

	private String relation;

	@Id
	@ManyToOne
	@JoinColumn(name = "member_followed")
	private MemberBean member_followed;

	public MemberBean getMember_follow() {
		return member_follow;
	}

	public void setMember_follow(MemberBean member_follow) {
		this.member_follow = member_follow;
	}

	public String getRelation() {
		return relation;
	}

	public void setRelation(String relation) {
		this.relation = relation;
	}

	public MemberBean getMember_followed() {
		return member_followed;
	}

	public void setMember_followed(MemberBean member_followed) {
		this.member_followed = member_followed;
	}
}
