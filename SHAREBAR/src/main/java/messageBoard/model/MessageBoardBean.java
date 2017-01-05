package messageBoard.model;

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
@Table(name="messageBoard" ,catalog="test3",schema="dbo")
public class MessageBoardBean {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	@ManyToOne
	@JoinColumn(name = "item_id")
	private ItemBean itemBean;
	@ManyToOne
	@JoinColumn(name="member_no")
	private MemberBean member_id;
	private String message;
	private java.util.Date time;
	private int show;
	
	public MessageBoardBean() {
	}
	
	public MessageBoardBean(ItemBean itemBean, MemberBean member_id, String message) {
		this.itemBean = itemBean;
		this.member_id = member_id;
		this.message = message;
		this.show = 1;
		this.time = new java.util.Date();
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public ItemBean getItem_id() {
		return itemBean;
	}
	public void setItem_id(ItemBean item_id) {
		this.itemBean = item_id;
	}
	public MemberBean getMember_id() {
		return member_id;
	}
	public void setMember_no(MemberBean member_id) {
		this.member_id = member_id;
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	public java.util.Date getTime() {
		return time;
	}
	public void setTime(java.util.Date time) {
		this.time = time;
	}
	public int getShow() {
		return show;
	}
	public void setShow(int show) {
		this.show = show;
	}
	
//	@Override
//	public String toString() {
//		return "MessageBoardBean [id=" + id + ", itemBean=" + itemBean + ", member_id=" + member_id + ", message="
//				+ message + ", time=" + time + ", show=" + show + "]";
//	}
	
	public static void main(String[] args) {
		ApplicationContext context = new ClassPathXmlApplicationContext("beans.config.xml");
		SessionFactory sessionFactory = (SessionFactory) context.getBean("sessionFactory");
		try {
			sessionFactory.getCurrentSession().beginTransaction();
			Session session = sessionFactory.getCurrentSession();

			MessageBoardBean select =  session.get(MessageBoardBean.class, 2);
			System.out.println(select);

			sessionFactory.getCurrentSession().getTransaction().commit();
		} finally {
			sessionFactory.close();
			((ConfigurableApplicationContext) context).close();
		}
		
	}
	
	
	
}
