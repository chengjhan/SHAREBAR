package message.model.dao;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import member.model.MemberBean;
import message.model.MessageContextBean;
import message.model.MessageContextDAO;

@Repository(value="messageContextDAO")
@Transactional
public class MessageContextDAOHibernate implements MessageContextDAO{
	@Autowired
	private SessionFactory sessionFactory;
	/* (non-Javadoc)
	 * @see message.model.dao.MessageContextDAO#getSession()
	 */
	@Override
	public Session getSession(){
		return sessionFactory.getCurrentSession();
	}	
	/* (non-Javadoc)
	 * @see message.model.dao.MessageContextDAO#select(int)
	 */
	@Override
	public MessageContextBean select(int id){
		return getSession().get(MessageContextBean.class,id);
	}
	/* (non-Javadoc)
	 * @see message.model.dao.MessageContextDAO#select(int, int)
	 */
	@Override
	public List<MessageContextBean> select(int item_id, int requester_id){
		@SuppressWarnings("unchecked")
		Query<MessageContextBean> query = getSession().createQuery(
				"from MessageContextBean where item_id = ? and member_id_listener = ? or item_id = ? and member_id_speaker = ?"); 
		query.setParameter(0, item_id);
		query.setParameter(1, requester_id);
		query.setParameter(2, item_id);
		query.setParameter(3, requester_id);
		
		return query.getResultList();
	}
	/* (non-Javadoc)
	 * @see message.model.dao.MessageContextDAO#mailForShare(int)
	 */
	@Override
	public List<Object[]> mailForShare(int member_id){
		@SuppressWarnings("unchecked")
		Query<Object[]> query = getSession().createQuery(
				"select a1.item_id, a1.item_name, a3.member_no, a3.nickname, MAX(a2.time), a5.status, a1.done, a1.getter_id.member_no from MessageContextBean a2 JOIN a2.itemBean a1 LEFT JOIN a2.memberBean_speaker a3 LEFT JOIN RequestListBean a5 with a1.item_id = a5.item_id AND a3.member_no = a5.requester_id where a1.member_id.member_no = ? AND a3.member_no <> ? GROUP BY a1.item_id, a1.item_name, a3.member_no, a3.nickname, a5.status, a1.done, a1.getter_id.member_no ORDER BY MAX(a2.time) DESC");
		query.setParameter(0, member_id);
		query.setParameter(1, member_id);
		return query.getResultList();
	};
	
	/* (non-Javadoc)
	 * @see message.model.dao.MessageContextDAO#mailForRequest(int)
	 */
	@Override
	public List<Object[]> mailForRequest(int member_id){
		@SuppressWarnings("unchecked")
		Query<Object[]> query = getSession().createQuery(
				"select a1.item_id , a1.item_name, a1.member_id.member_no, a4.nickname, MAX(a2.time), a5.status, a1.done, a1.getter_id.member_no from MessageContextBean a2 JOIN a2.itemBean a1 LEFT JOIN a2.memberBean_speaker a3 LEFT JOIN a2.memberBean_listener a4 LEFT JOIN RequestListBean a5 with a1.item_id = a5.item_id AND a2.memberBean_speaker.member_no = a5.requester_id where a1.member_id.member_no <> ? AND a3.member_no = ? GROUP BY a1.item_id , a1.item_name, a1.member_id.member_no, a4.nickname, a5.status, a1.done, a1.getter_id.member_no ORDER BY MAX(a2.time) DESC");	
		query.setParameter(0, member_id);
		query.setParameter(1, member_id);
		return query.getResultList();
	};
	
	/* (non-Javadoc)
	 * @see message.model.dao.MessageContextDAO#insert(message.model.MessageContextBean)
	 */
	@Override
	public void insert(MessageContextBean bean){
		getSession().save(bean);
	}
}
