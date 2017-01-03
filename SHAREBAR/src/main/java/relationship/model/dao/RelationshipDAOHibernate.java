package relationship.model.dao;

import java.util.List;

import javax.persistence.NoResultException;
import javax.persistence.Query;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import member.model.MemberBean;
import relationship.model.RelationshipBean;
import relationship.model.RelationshipDAO;

@Repository(value = "relationshipDao")
public class RelationshipDAOHibernate implements RelationshipDAO {

	// private SessionFactory sessionFactory;
	//
	// public RelationshipDAOHibernate(SessionFactory sessionFactory) {
	// this.sessionFactory = sessionFactory;
	// }
	//
	// public Session getSession() {
	// return sessionFactory.getCurrentSession();
	// }
	@Autowired
	private SessionFactory sessionFactory;

	/* (non-Javadoc)
	 * @see model.dao.RelationshipDAO#getSession()
	 */
	@Override
	public Session getSession() {
		return sessionFactory.getCurrentSession();
	}

	/* (non-Javadoc)
	 * @see model.dao.RelationshipDAO#insert(model.relationship.RelationshipBean)
	 */
	@Override
	public RelationshipBean insert(RelationshipBean bean) {
		if (bean != null) {
			this.getSession().save(bean);
			System.out.println("bean update success");
			return bean;
		}
		return null;
	}

	/* (non-Javadoc)
	 * @see model.dao.RelationshipDAO#update(model.member.MemberBean, java.lang.String, model.member.MemberBean)
	 */
	@Override
	public boolean update(MemberBean follow, String relation, MemberBean followed) {
		System.out.println("follow= "+follow+", followed= "+followed+", relation= "+relation);
		if (follow != null && followed != null && relation != null) {
			Query query = this.getSession().createQuery(
					"update RelationshipBean set relation = :relation where member_follow = :member_follow and member_followed = :member_followed");
			query.setParameter("relation", relation);
			query.setParameter("member_follow", follow);
			query.setParameter("member_followed", followed);
			int updateCount = query.executeUpdate();
			if (updateCount == 1) {
				System.out.println("updateCount= "+updateCount);
				return true;
			}else{
				System.out.println("updateCount= "+updateCount);
			}
		}
		return false;
	}

	/* (non-Javadoc)
	 * @see model.dao.RelationshipDAO#normalInsert(model.relationship.RelationshipBean)
	 */
	@Override
	public RelationshipBean normalInsert(RelationshipBean bean) {
		if (bean != null) {
			this.getSession().save(bean);
			return bean;
		}
		return null;
	}

	/* (non-Javadoc)
	 * @see model.dao.RelationshipDAO#selectAll()
	 */
	@Override
	public List<RelationshipBean> selectAll() {
		Query query = this.getSession().createQuery("from RelationshipBean");
		List<RelationshipBean> results = (List) query.getResultList();
		if (!results.isEmpty()) {
			return results;
		}
		return null;
	}

	/* (non-Javadoc)
	 * @see model.dao.RelationshipDAO#selectByBean(model.member.MemberBean, model.member.MemberBean)
	 */
	@Override
	public RelationshipBean selectByBean(MemberBean mb, MemberBean check) {
		RelationshipBean rel = null;
//		System.out.println("mb no:"+mb.getMember_no()+" check no: "+check.getMember_no());
		Query query = this.getSession().createQuery("from RelationshipBean where member_follow = :member_follow and member_followed = :member_followed");
		query.setParameter("member_follow", mb);
		query.setParameter("member_followed", check);
		try {
			rel = (RelationshipBean) query.getSingleResult();
			if(rel != null){
				System.out.println(rel);
				return rel;
			}
		} catch (NoResultException e) {
			System.out.println("no results");
//			e.printStackTrace();
		}
		return null;
	}
	
	/* (non-Javadoc)
	 * @see model.dao.RelationshipDAO#selectByFollow(model.member.MemberBean)
	 */
	@Override
	public List<RelationshipBean> selectByFollow(MemberBean mb){
		Query query = this.getSession().createQuery("from RelationshipBean where member_follow = :member_follow and relation = :relation");
		query.setParameter("member_follow", mb);
		query.setParameter("relation", "follow");
		List<RelationshipBean> results = (List<RelationshipBean>) query.getResultList();
		if(!results.isEmpty()){
			return results;
		}
		return null;
	}
	
	@Override
	public List<RelationshipBean> selectByFollowed(MemberBean mb){
		Query query = this.getSession().createQuery("from RelationshipBean where member_followed = :member_followed and relation = :relation");
		query.setParameter("member_followed", mb);
		query.setParameter("relation", "follow");
		List<RelationshipBean> results = (List<RelationshipBean>) query.getResultList();
		if(!results.isEmpty()){
			return results;
		}
		return null;
	}

	// static public void main(String[] args) {
	//
	// try {
	// HibernateUtil.getSessionFactory().getCurrentSession().beginTransaction();
	// RelationshipDAO relationshipDao = new
	// RelationshipDAOHibernate(HibernateUtil.getSessionFactory());
	// MemberDAO memberDao = new
	// MemberDAOHibernate(HibernateUtil.getSessionFactory());
	//// RelationshipBean bean = new RelationshipBean();
	//// MemberBean mb1 = memberDao.selectByNo(13);
	//// MemberBean mb2 = memberDao.selectByNo(10);
	//// bean.setMember_follow(mb1);
	//// bean.setMember_followed(mb2);
	//// bean.setRelation("block");
	//// System.out.println(relationshipDao.update(mb1, bean.getRelation(),
	// mb2));
	//// System.out.println(relationshipDao.insert(bean)); //OK
	// for(RelationshipBean beans : relationshipDao.selectAll()){
	// System.out.println(" member_no
	// "+beans.getMember_follow().getMember_no()+" "+beans.getRelation()+"
	// member_no " + beans.getMember_followed().getMember_no());
	// }
	//
	// HibernateUtil.getSessionFactory().getCurrentSession().getTransaction().commit();
	// } catch (Exception e) {
	// e.printStackTrace();
	// } finally {
	// HibernateUtil.closeSessionFactory();
	// }
	// }
}
