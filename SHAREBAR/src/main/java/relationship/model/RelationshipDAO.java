package relationship.model;

import java.util.List;

import org.hibernate.Session;

import member.model.MemberBean;

public interface RelationshipDAO {

	Session getSession();

	RelationshipBean insert(RelationshipBean bean);

	boolean update(MemberBean follow, String relation, MemberBean followed);

	RelationshipBean normalInsert(RelationshipBean bean);

	List<RelationshipBean> selectAll();

	RelationshipBean selectByBean(MemberBean mb, MemberBean check);

	List<RelationshipBean> selectByFollow(MemberBean mb);

	List<RelationshipBean> selectByFollowed(MemberBean mb);

}