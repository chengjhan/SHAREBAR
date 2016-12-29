package followitem.model.dao;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ConfigurableApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Repository;

import followitem.model.FollowItemsBean;
import followitem.model.FollowItemsDAO;
import item.model.dao.ItemDAOHibernate;
import member.model.dao.MemberDAOHibernate;

@Repository(value="followItemsDao")
public class FollowItemDAOhibernate implements FollowItemsDAO {
	
	@Autowired
	private SessionFactory sessionFactory;
//	@Autowired
//	private MemberDAOHibernate memberDAOHibernate;
//	@Autowired
//	private ItemDAOHibernate itemDAOHibernate;

	public Session getsesssion(){
		return sessionFactory.getCurrentSession();
	}

	
	
	public List<FollowItemsBean> select(int member_no) {
		Query query = this.getsesssion().createQuery("from FollowItemsBean where member_no=:member_no and status=1 ");
		query.setParameter("member_no",member_no);
		List<FollowItemsBean> beans= query.getResultList();
		return beans;
	}
	
	public FollowItemsBean select (int member_no,int item_id){
		Query query = this.getsesssion().createQuery("from FollowItemsBean where member_no=:member_no and item_id=:item_id ");
		query.setParameter("member_no", member_no);
		query.setParameter("item_id", item_id);
		
		List<FollowItemsBean> beans = query.getResultList();
		if(beans.isEmpty()){
			return null;
		}
		FollowItemsBean thisbean = beans.get(0);
		return thisbean;
		
	}
	
	

	public FollowItemsBean insert(FollowItemsBean followitembean) {
		this.getsesssion().saveOrUpdate(followitembean);
		FollowItemsBean thisbean = this.getsesssion().get(FollowItemsBean.class,followitembean.getFollowing_item_id() );
		return thisbean;
	}
	
	
	public int update(int member_no,int item_id) {
		int Itemstatus;
		
		FollowItemsBean thisbean = select(member_no, item_id);
			
		if(null == thisbean){
			return 0;
		}
		else{
			Itemstatus = thisbean.getStatus();
			if(Itemstatus == 0){
				thisbean.setStatus(1);
				return 1;
			}
			else thisbean.setStatus(0);{
				return 0;	
			}
		}
		}	
	

	public boolean delate(int member_no,int item_id) {
		Query query = this.getsesssion().createQuery("from FollowItemsBean where member_no=:member_no and item_id=:item_id");
		query.setParameter("member_no", member_no);
		query.setParameter("item_id", item_id);
		
		List<FollowItemsBean> result= query.getResultList();
		if(result.isEmpty()){
			return false; 
		}
		else{
			FollowItemsBean delatethis = result.get(0);
			this.getsesssion().delete(delatethis);
			return true;
		}
	}
	
	
	
	/****************測試******************/
	public static void main(String[] args) {
		ApplicationContext context = new ClassPathXmlApplicationContext("beans.config.xml");
		SessionFactory sessionfactory = (SessionFactory) context.getBean("sessionFactory");
		
		try{
			sessionfactory.getCurrentSession().beginTransaction();
			FollowItemsDAO followItemsDao = (FollowItemsDAO) context.getBean("followItemsDao");
			
//			//insert
//			FolloweItemsBean insertbean = new FolloweItemsBean();
//			
//			insertbean.setItemBean(sessionfactory.getCurrentSession().get(ItemBean.class, 32));
//			insertbean.setMember_id(2);
//			insertbean.setStatus(1);
//			
//			FolloweItemsBean resoult = followerItemsDao.insert(insertbean);
//			System.out.println(resoult);
			
//			//update
//			int updateresoult= followItemsDao.update(1, 21);
//			System.out.println(updateresoult);
			
//			//select(list)
//			System.out.println(followItemsDao.select(1));
			
			//select
			System.out.println(followItemsDao.select(4,32));
			
//			//delate
//			System.out.println(followItemsDao.delate(2, 16)); 
			
//			//HQL 查詢測試
//			Session session = sessionfactory.getCurrentSession();
//			Query query = session.createQuery("from FollowItemsBean where member_no=:member_no and item_id=:item_id ");
//			query.setParameter("member_no", 4);
//			query.setParameter("item_id", 21);
//			System.out.println(query.getResultList());
//			
//			sessionfactory.getCurrentSession().getTransaction().commit();
		}

		finally{
			sessionfactory.close();
			((ConfigurableApplicationContext)context).close();
		}	
		
		
		
	}



	
}
