package message.model.dao;

import javax.persistence.NoResultException;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import message.model.RequestListBean;
import message.model.RequestListDAO;

@Repository(value="requestListDAO")
@Transactional
public class RequestListDAOHibernate implements RequestListDAO {
	@Autowired
	private SessionFactory sessionFactory;
	/* (non-Javadoc)
	 * @see message.model.dao.RequestListDAO#getSession()
	 */
	@Override
	public Session getSession(){
		return sessionFactory.getCurrentSession();
	}
	
	/* (non-Javadoc)
	 * @see message.model.dao.RequestListDAO#select(int, int)
	 */
	@Override
	public RequestListBean select(int item_id, int requester_id){
		@SuppressWarnings("rawtypes")
		Query query = getSession().createQuery(" FROM RequestListBean WHERE item_id = ? AND requester_id = ? ");
		query.setParameter(0, item_id);
		query.setParameter(1, requester_id);
		
		RequestListBean bean = null;
		try{
			bean = (RequestListBean) query.getSingleResult();
			return bean;
		}catch(NoResultException e){System.out.println("no results");}
		return bean;
	}
	
	/* (non-Javadoc)
	 * @see message.model.dao.RequestListDAO#checkStatus(int, int)
	 */
	@Override
	public String checkStatus(int item_id, int requester_id){
		RequestListBean bean = null;		
		try{
			@SuppressWarnings("rawtypes")
			Query query = getSession().createQuery(" FROM RequestListBean WHERE item_id = ? AND requester_id = ? ");
			query.setParameter(0, item_id);
			query.setParameter(1, requester_id);
			System.out.println(query);
			bean = (RequestListBean) query.getSingleResult();
			return bean.getStatus();
		} 
		catch( NullPointerException e1) {System.out.println("系統:會員(" + requester_id + ")對此物品未進行請求");}
		catch( NoResultException e2) {System.out.println("系統:同上");}
		return "未提出";
	}
	
	/* (non-Javadoc)
	 * @see message.model.dao.RequestListDAO#asking(int, int)
	 */
	@Override
	public void asking(int item_id, int requester_id){
		RequestListBean bean = new RequestListBean();
		bean.setItem_id(item_id);
		bean.setRequester_id(requester_id);
		bean.setStatus("已送出");
		bean.setTime(new java.util.Date());
		getSession().saveOrUpdate(bean);
	}
	
	/* (non-Javadoc)
	 * @see message.model.dao.RequestListDAO#refused(int, int)
	 */
	@Override
	public void refused(int item_id, int requester_id){
		RequestListBean bean = new RequestListBean();
		bean.setItem_id(item_id);
		bean.setRequester_id(requester_id);
		bean.setStatus("已拒絕");
		bean.setTime(new java.util.Date());
		getSession().saveOrUpdate(bean);		
	}
	/* (non-Javadoc)
	 * @see message.model.dao.RequestListDAO#acepted(int, int)
	 */
	@Override
	public void acepted(int item_id, int requester_id){
		RequestListBean bean = new RequestListBean();
		bean.setItem_id(item_id);
		bean.setRequester_id(requester_id);
		bean.setStatus("已成交");
		bean.setTime(new java.util.Date());
		getSession().saveOrUpdate(bean);		
	}
}
