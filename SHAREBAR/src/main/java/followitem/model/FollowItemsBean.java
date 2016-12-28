package followitem.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ConfigurableApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import item.model.ItemBean;
import member.model.MemberBean;

@Entity
@Table(name = "followitems", catalog = "test3", schema = "dbo")
public class FollowItemsBean {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int following_item_id;
	
	@ManyToOne
	@JoinColumn(name = "member_no")
	private MemberBean member_id;
	
	@ManyToOne
	@JoinColumn(name = "item_id")
	private ItemBean ItemBean;
	
	private int status;
	
	
	public int getFollowing_item_id() {
		return following_item_id;
	}
	public void setFollowing_item_id(int following_item_id) {
		this.following_item_id = following_item_id;
	}
	public MemberBean getMember_id() {
		return member_id;
	}
	public void setMember_id(MemberBean memberBean) {
		member_id = memberBean;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	public ItemBean getItemBean() {
		return ItemBean;
	}
	public void setItemBean(ItemBean itemBean) {
		ItemBean = itemBean;
	}
	
	
//	@Override
//	public String toString() {
//		return "FollowerItemsBean [ItemBean=" + ItemBean + ", status=" + status + "]";
//	}
	
	/****************測試******************/
	public static void main(String[] args) {
		ApplicationContext context = new ClassPathXmlApplicationContext("beans.config.xml");
		SessionFactory sessionFactory = (SessionFactory) context.getBean("sessionFactory");
		
		try {
			sessionFactory.getCurrentSession().beginTransaction();
			Session session = sessionFactory.getCurrentSession();
			
			
			//select
			FollowItemsBean select = (FollowItemsBean) session.get(FollowItemsBean.class, 3);
			System.out.println(select);
			
//			//insert
//			FolloweItemsBean insertbean = new FolloweItemsBean();
//			insertbean.setItemBean(session.get(ItemBean.class, 32));
//			insertbean.setMemberBean(session.get(MemberBean.class,4));
//			insertbean.setStatus(0);
//			session.save(insertbean);
			
//			//update
//			FolloweItemsBean updatebean = new FolloweItemsBean();
//			updatebean = session.get(FolloweItemsBean.class, 3);
//			updatebean.setStatus(1);
//			System.out.println(updatebean);
			 
			
			
			sessionFactory.getCurrentSession().getTransaction().commit();
		} finally {
			sessionFactory.close();
			((ConfigurableApplicationContext) context).close();
		}
		
	}
	
	

}
