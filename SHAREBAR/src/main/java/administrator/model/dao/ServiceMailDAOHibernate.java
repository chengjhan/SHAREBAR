package administrator.model.dao;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;


import administrator.model.ServiceMailBean;
import administrator.model.ServiceMailDAO;

@Repository(value="serviceMailDao")
@Transactional
public class ServiceMailDAOHibernate implements ServiceMailDAO {

	
	@Autowired
	private SessionFactory sessionFactory;

	public ServiceMailDAOHibernate(SessionFactory sessionFactory) {
		this.sessionFactory = sessionFactory;
	}

	@Override
	public Session getSession() {
		return sessionFactory.getCurrentSession();
	}

	
	
	
	//(1)選取  會員撈出自己member_id的信件

	@Override
	@SuppressWarnings("unchecked")
	public List<ServiceMailBean> selectMemberMail(int member_id){
		Query<ServiceMailBean> query = this.getSession().createQuery(
				"from ServiceMailBean where member_id=?");
		query.setParameter(0, member_id);		
		return query.getResultList();
	}
	
	//(2)選取  GM撈出所有檢舉信件

	@Override
	@SuppressWarnings("unchecked")
	public List<ServiceMailBean> selectAllMail(){
		Query<ServiceMailBean> query = this.getSession().createQuery(
				"from ServiceMailBean"); 	
		return query.getResultList();
	}
	
	//(3)insert 會員寫檢舉信

	@Override
	public ServiceMailBean insertMail(ServiceMailBean bean){
		this.getSession().save(bean);
		return bean;
	}
	
	//(4)insert GM回覆檢舉信

	@Override
	public ServiceMailBean replyMail(int mail_id ,String reply_context) {
		ServiceMailBean bean = this.getSession().get(ServiceMailBean.class,  mail_id);
		bean.setReply_time(new java.util.Date());
		bean.setGm_reply_context(reply_context);
		
		return bean;	
		
		
		
	}
	
}
