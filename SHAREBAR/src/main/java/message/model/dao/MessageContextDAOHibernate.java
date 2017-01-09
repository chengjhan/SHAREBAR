package message.model.dao;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import message.model.MessageContextBean;
import message.model.MessageContextDAO;

@Repository(value="messageContextDAO")
@Transactional
public class MessageContextDAOHibernate implements MessageContextDAO{
	@Autowired
	private SessionFactory sessionFactory;

	@Override
	public Session getSession(){
		return sessionFactory.getCurrentSession();
	}	

	@Override
	public MessageContextBean select(int id){
		return getSession().get(MessageContextBean.class,id);
	}

	@Override
	public List<MessageContextBean> select(int item_id, int requester_id){
//		int top = 5;
//		int startPoint = 0;
//		int endPoint = 5;
		@SuppressWarnings("unchecked")
		Query<MessageContextBean> query = getSession().createQuery(
//		@SuppressWarnings({ "unchecked" })
//		Query<MessageContextBean> query = getSession().createNativeQuery(
				"from MessageContextBean where item_id = ? and member_id_listener = ? or item_id = ? and member_id_speaker = ?"); 
//				"from MessageContextBean a where a.messageNo in ( SELECT b.messageNo from MessageContextBean b where b.itemBean.item_id = ? and b.memberBean_listener.member_no = ? or b.itemBean.item_id = ? and b.memberBean_speaker.member_no = ? ORDER BY b.messageNo DESC LIMIT 0,5 ) ORDER BY a.messageNo ASC"); 				
//				"select * from ( select TOP(?) * , ROW_NUMBER() OVER(ORDER BY messageNo DESC) row from messageContext where item_id = ? and member_id_listener = ? or item_id = ? and member_id_speaker = ? ORDER BY messageNo DESC ) a WHERE row >= ? AND row <? ORDER BY a.messageNo ASC");
//		query.setParameter(0, top);
//		query.setParameter(1, item_id);
//		query.setParameter(2, requester_id);
//		query.setParameter(3, item_id);
//		query.setParameter(4, requester_id);
//		query.setParameter(5, startPoint);
//		query.setParameter(6, endPoint);
		query.setParameter(0, item_id);
		query.setParameter(1, requester_id);
		query.setParameter(2, item_id);
		query.setParameter(3, requester_id);
		
		return query.getResultList();
	}

	@Override
	public List<Object[]> mailForShare(int member_id){
		@SuppressWarnings("unchecked")
		Query<Object[]> query = getSession().createQuery(
				"select a1.item_id, a1.item_name, a3.member_no, a3.nickname, MAX(a2.time), a5.status, a1.done, a1.getter_id.member_no, a1.getter_rate, a1.giver_rate, MIN(a2.readed) from MessageContextBean a2 JOIN a2.itemBean a1 LEFT JOIN a2.memberBean_speaker a3 LEFT JOIN RequestListBean a5 with a1.item_id = a5.item_id AND a3.member_no = a5.requester_id where a1.member_id.member_no = ? AND a3.member_no <> ? GROUP BY a1.item_id, a1.item_name, a3.member_no, a3.nickname, a5.status, a1.done, a1.getter_id.member_no, a1.getter_rate, a1.giver_rate ORDER BY MAX(a2.time) DESC");
		query.setParameter(0, member_id);
		query.setParameter(1, member_id);
		return query.getResultList();
	};
	

	@Override
	public List<Object[]> mailForRequest(int member_id){
		@SuppressWarnings("unchecked")
		Query<Object[]> query = getSession().createQuery(
				"select a1.item_id , a1.item_name, a1.member_id.member_no, a4.nickname, MAX(a2.time), a5.status, a1.done, a1.getter_id.member_no, a1.getter_rate, a1.giver_rate, MIN(a2.readed) from MessageContextBean a2 JOIN a2.itemBean a1 LEFT JOIN a2.memberBean_speaker a3 LEFT JOIN a2.memberBean_listener a4 LEFT JOIN RequestListBean a5 with a1.item_id = a5.item_id AND a2.memberBean_speaker.member_no = a5.requester_id where a1.member_id.member_no <> ? AND a3.member_no = ? GROUP BY a1.item_id , a1.item_name, a1.member_id.member_no, a4.nickname, a5.status, a1.done, a1.getter_id.member_no, a1.getter_rate, a1.giver_rate ORDER BY MAX(a2.time) DESC");	
		query.setParameter(0, member_id);
		query.setParameter(1, member_id);		
		return query.getResultList();
	};
	
	@Override
	public int mailUnreaded(int member_id){	
		@SuppressWarnings("rawtypes")
		Query query = getSession().createNativeQuery(
				"select count(*) from ( select distinct item_id, member_id_speaker, member_id_listener, readed from messageContext where readed = 0	) a where a.member_id_listener = ?");	
//		select count(*) 
//		from (
//			select distinct item_id, member_id_speaker, member_id_listener, readed
//			from messageContext 
//			where readed = 0	
//		)　a
//		where a.member_id_listener = 1
		query.setParameter(1, member_id);	
		return (int) query.getSingleResult();
	};
	
	@Override
	public void mailReaded(int item_id, int speaker_id, int listener_id){
		@SuppressWarnings({ "rawtypes" })
		Query query = getSession().createNativeQuery(
				"UPDATE messageContext SET readed = 1 WHERE item_id = ? AND member_id_speaker = ? AND member_id_listener = ? AND readed = 0");
		query.setParameter(1, item_id);
		query.setParameter(2, speaker_id);
		query.setParameter(3, listener_id);
		query.executeUpdate();
	};	
	
	@Override
	public void insert(MessageContextBean bean){
		getSession().save(bean);
	}
}
