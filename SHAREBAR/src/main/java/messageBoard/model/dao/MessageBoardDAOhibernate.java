package messageBoard.model.dao;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.annotations.Check;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ConfigurableApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Repository;

import item.model.ItemBean;
import item.model.ItemDAO;
import item.model.dao.ItemDAOHibernate;
import member.model.MemberBean;
import member.model.MemberDAO;
import member.model.dao.MemberDAOHibernate;
import messageBoard.model.MessageBoardBean;
import messageBoard.model.MessageBoardDAO;

@Repository(value="messageBoardDao")
public class MessageBoardDAOhibernate implements MessageBoardDAO {
	
	@Autowired
	private SessionFactory sessionFactory;
	
	public Session getsession(){
		return sessionFactory.getCurrentSession();
	}
	
	@Override
	public Boolean addmessage(MessageBoardBean messageboardbean) {
		if(messageboardbean!=null){
			this.getsession().saveOrUpdate(messageboardbean);
			return true;
		}
		else return false;
	}

	@Override
	public Boolean edit(MessageBoardBean messageboardbean) {
		int id = messageboardbean.getId();
		MessageBoardBean check_bean = this.getsession().get(MessageBoardBean.class, id);
		if(check_bean!=null){
			this.getsession().saveOrUpdate(messageboardbean);
			return true;
		}
		else {
			System.out.println("無此資料");
			return false;
		}
	}

	@Override
	public int showSwitch(int id) {
		MessageBoardBean messageboardbean = this.getsession().get(MessageBoardBean.class, id);
		messageboardbean.setTime(new java.util.Date());
		int check = messageboardbean.getShow();
		if(check == 0){
			messageboardbean.setShow(1);
			return 1;
		}
		else messageboardbean.setShow(0);
		return 0;
	}

	@Override
	public List<String> selectByItemid(int item_id) {
		Query query = this.getsession().createQuery("from MessageBoardBean where item_id=:item_id ");
		query.setParameter("item_id", item_id);
		List<String> result = query.getResultList();
		return result;
	}
	@Override
	public MessageBoardBean selectById(int id){
		MessageBoardBean messageboardbean = this.getsession().get(MessageBoardBean.class, id);
		return messageboardbean;
		
	}

	public static void main(String[] args) {
		ApplicationContext context = new ClassPathXmlApplicationContext("beans.config.xml");
		SessionFactory sessionFactory = (SessionFactory) context.getBean("sessionFactory");
		
		try {
			sessionFactory.getCurrentSession().beginTransaction();
			MessageBoardDAOhibernate messageBoardDao = (MessageBoardDAOhibernate) context.getBean("messageBoardDao");
			MemberDAO memberdao = (MemberDAO) context.getBean("memberDao");
			ItemDAO itemDao = (ItemDAO) context.getBean("itemDao");
			
//			//addmessage
//			MessageBoardBean messageboardbean = new MessageBoardBean();
//			
//			ItemBean itembean = itemDao.selectById(13);
//			MemberBean memberbean = memberdao.selectByNo(28);
//			
//			messageboardbean.setItem_id(itembean);
//			messageboardbean.setMember_no(memberbean);
//			messageboardbean.setMessage("這是第一篇留言 test test test");
//			messageboardbean.setShow(1);
//			messageboardbean.setTime(new java.util.Date());
//			messageBoardDao.addmessage(messageboardbean);
			
			//showSwitch
			System.out.println(messageBoardDao.showSwitch(4));
			
//			//selectByItemid
//			System.out.println(messageBoardDao.selectByItemid(15));
			
//			//selectById
//			System.out.println(messageBoardDao.selectById(4));
			
//			//edit
//			MessageBoardBean edit = messageBoardDao.selectById(2);
//			edit.setMessage("PS4 GET 3Q deaaaaz");
//			messageBoardDao.edit(edit);
			
			
			sessionFactory.getCurrentSession().getTransaction().commit();
			sessionFactory.getCurrentSession().close();
		
		}catch(Exception e){
			sessionFactory.getCurrentSession().getTransaction().rollback();
			e.printStackTrace();
		}
		
		finally {
			sessionFactory.close();
			((ConfigurableApplicationContext)context).close();
		}
		
		

	}

}
