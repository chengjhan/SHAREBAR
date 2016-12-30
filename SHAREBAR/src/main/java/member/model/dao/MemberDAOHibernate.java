package member.model.dao;

import java.util.List;

import javax.persistence.NoResultException;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import member.model.MemberBean;
import member.model.MemberDAO;

@Repository(value = "memberDao")
public class MemberDAOHibernate implements MemberDAO {

	// private SessionFactory sessionFactory;
	//
	// public MemberDAOHibernate(SessionFactory sessionFactory) {
	// this.sessionFactory = sessionFactory;
	// }
	//
	// public Session getSession() {
	// return sessionFactory.getCurrentSession();
	// }

	@Autowired
	private SessionFactory sessionFactory;

	/*
	 * (non-Javadoc)
	 * 
	 * @see model.dao.MemberDAO#getSession()
	 */
	@Override
	public Session getSession() {
		return sessionFactory.getCurrentSession();
	}
	// private SessionFactory sessionFactory;
	// public Session getSession(){
	// return sessionFactory.getCurrentSession();
	// }

	// public MemberBean select(String member_email) {
	// MemberBean bean = null;
	// Query query = (Query) this.getSession().createQuery("from MemberBean
	// where member_email = ?");
	// query.setParameter(0, member_email);
	// try {
	// bean = (MemberBean) query.getSingleResult();
	// } catch (Exception e) {
	// e.printStackTrace();
	// System.out.println("can't found this user");
	// }
	// return bean;
	// }

	// public MemberBean selectBytoken(String token) {
	// MemberBean bean = null;
	// Query query = (Query) this.getSession().createQuery("from MemberBean
	// where activate_token = ?");
	// query.setParameter(0, token);
	// try {
	// bean = (MemberBean) query.getSingleResult();
	// } catch (Exception e) {
	// e.printStackTrace();
	// }
	// return bean;
	// }

	// OK
	/*
	 * (non-Javadoc)
	 * 
	 * @see model.dao.MemberDAO#select()
	 */
	@Override
	public List<MemberBean> select() {
		Query query = this.getSession().createQuery("from MemberBean order by member_no");
		List<MemberBean> list = query.getResultList();
		return list;
	}

	@Override
	public MemberBean selectByEmail(String email) {
		Query query = this.getSession().createQuery("from MemberBean where email = :email");
		query.setParameter("email", email);
		MemberBean bean = null;
		try {
			bean = (MemberBean) query.getSingleResult();
		} catch (NoResultException e) {
			System.out.println("no results");
		}
		if (bean != null) {
			return bean;
		}
		return null;
	}

	public MemberBean selectByToken(String token) {
		Query query = this.getSession().createQuery("from MemberBean where activate_token = :activate_token");
		query.setParameter("activate_token", token);
		MemberBean bean = null;
		try {
			bean = (MemberBean) query.getSingleResult();
			return bean;
		} catch (NoResultException e) {
			System.out.println("no results");
		}
		return bean;
	}

	@Override
	public MemberBean normalInsert(MemberBean bean) {
		this.getSession().save(bean);
		return bean;
	}

	@Override
	public MemberBean insert(MemberBean bean) {

		if (bean != null) {
			Query query = this.getSession().createQuery("from MemberBean where email = :email");
			query.setParameter("email", bean.getEmail());
			List<MemberBean> results = query.getResultList();
			if (results.isEmpty()) {
				this.getSession().save(bean);
				return bean;
			}
		}
		return null;
	}

	@Override
	public int accountActivate(String token) {
		Query query = this.getSession()
				.createQuery("update MemberBean set certification = :certification where activate_token = :token");
		query.setParameter("certification", 1);
		query.setParameter("token", token);
		int updateCount = query.executeUpdate();
		return updateCount;
	}

	@Override
	public boolean delete(int member_no) {
		// TODO Auto-generated method stub
		MemberBean delete = (MemberBean) this.getSession().get(MemberBean.class, member_no);
		if (delete != null) {
			this.getSession().delete(delete);
			return true;
		}
		return false;
	}

	@Override
	public MemberBean selectByNo(int member_no) {
		MemberBean bean = null;
		try {
			bean = this.getSession().get(MemberBean.class, member_no);
			if (bean != null) {
				return bean;
			}
		} catch (NoResultException e) {
			System.out.println("no result");
		}
		return null;
	}

	public MemberBean selctByFb(String facebookId) {
		Query query = this.getSession().createQuery("from MemberBean where facebook = :facebook");
		query.setParameter("facebook", facebookId);
		MemberBean bean = null;
		try {
			bean = (MemberBean) query.getSingleResult();
			return bean;
		} catch (NoResultException e) {
			System.out.println("no results");
		}
		return bean;
	}

	public MemberBean update2(int member_no, String firstName, String lastName, String country, String city,
			String nickname, String description, String photo) {
		MemberBean update = this.getSession().get(MemberBean.class, member_no);
		if (update != null) {
			update.setFirst_name(firstName);
			update.setLast_name(lastName);
			update.setCountry(country);
			update.setCity(city);
			update.setNickname(nickname);
			update.setDescription(description);
			update.setPhoto(photo);
		}
		return update;
	}

	public MemberBean update(int member_no, String firstName, String lastName, String country, String city,
			String nickname, String description) {
		MemberBean update = this.getSession().get(MemberBean.class, member_no);
		if (update != null) {
			update.setFirst_name(firstName);
			update.setLast_name(lastName);
			update.setCountry(country);
			update.setCity(city);
			update.setNickname(nickname);
			update.setDescription(description);
		}
		return update;
	}

	public MemberBean updateFb(int member_no, String facebookId) {
		MemberBean update = this.getSession().get(MemberBean.class, member_no);
		if (update != null) {
			update.setFacebook(facebookId);
		}
		return update;
	}

	// fot Tian
	@Override
	public List<MemberBean> selectBlockMember() {
		Query query = this.getSession().createQuery("from MemberBean where blockdate is not null order by member_no");
		try {
			List<MemberBean> results = query.getResultList();
			if (!results.isEmpty()) {
				return results;
			}
		} catch (NullPointerException ex) {
			System.out.println("no results");
		}
		return null;
	}

	@Override
	public MemberBean updateMemberBlock(MemberBean bean) {
		MemberBean update = this.getSession().get(MemberBean.class, bean.getMember_no());
		if (update != null) {
			update.setBlockdate(bean.getBlockdate());
		}
		return update;
	}
	// public static void main(String[] args) throws Exception {
	// try {
	// HibernateUtil.getSessionFactory().getCurrentSession().beginTransaction();
	// MemberDAO memberDao = new
	// MemberDAOHibernate(HibernateUtil.getSessionFactory());
	// // insert test
	//// MemberBean memberBean = new MemberBean();
	//// memberBean.setMember_email("test3@gmail.com");
	//// memberBean.setPassword("testpassword");
	//// memberBean.setMember_nickname("Lan");
	// // System.out.println(memberDao.normalInsert(memberBean));
	// //System.out.println(memberDao.insert(memberBean));
	//// memberDao.update("test6@gmail.com", "adsfdsaf", "TEST6", null, "I am
	// test 6");
	//// System.out.println("activate
	// account:"+memberDao.accountActivate("aaa"));
	//// System.out.println(memberDao.delete(4));
	//// System.out.println(memberDao.selectByNo(3));
	//
	// for (MemberBean bean : memberDao.select()) {
	// System.out.print("member_no: " + bean.getMember_no() + " member_email: "
	// + bean.getMember_email()
	// + " member_nickname " + bean.getMember_nickname()+" certificaton: "+
	// bean.getCertification());
	// System.out.print(",,, follow: member_no ");
	// for (RelationshipBean rb : bean.getMember_follow_rel()) {
	// System.out.print(rb.getMember_followed().getMember_no()+" ");
	// }
	// System.out.println("");
	// }
	// HibernateUtil.getSessionFactory().getCurrentSession().getTransaction().commit();
	// } catch (Exception e) {
	// e.printStackTrace();
	// } finally {
	// HibernateUtil.closeSessionFactory();
	// }
	// }
}
