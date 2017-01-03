package item.model;

import java.util.HashSet;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.OrderBy;
import javax.persistence.Table;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ConfigurableApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.google.gson.annotations.Expose;

import category.model.ClassBean;
import image.model.ImageBean;

@Entity
@Table(name = "item")
public class ItemBean {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Expose
	private int item_id;
	@Expose
	private String item_name;
	private String item_description;
	@Expose
	private String member_id;
	@Expose
	private String location;
	@ManyToOne
	@JoinColumn(name = "class_id")
	@Expose
	private ClassBean classBean;
	@Expose
	private double latitude;
	@Expose
	private double longitude;
	private java.util.Date post_date;
	@Expose
	private java.util.Date end_date;
	private int block;
	private int done;
	private String getter_id;
	private int getter_rate;
	private String getter_review;
	private int giver_rate;
	private String giver_review;
	@OneToMany(cascade = CascadeType.REMOVE, fetch = FetchType.EAGER, mappedBy = "itemBean")
	@OrderBy("image_id ASC")
	@Expose
	private Set<ImageBean> imageBean = new HashSet<ImageBean>();

	@Override
	public String toString() {
		return "ItemBean [item_id=" + item_id + ", item_name=" + item_name + ", member_id=" + member_id + "]\n"
				+ imageBean;
	}

	public int getItem_id() {
		return item_id;
	}

	public void setItem_id(int item_id) {
		this.item_id = item_id;
	}

	public String getItem_name() {
		return item_name;
	}

	public void setItem_name(String item_name) {
		this.item_name = item_name;
	}

	public String getItem_description() {
		return item_description;
	}

	public void setItem_description(String item_description) {
		this.item_description = item_description;
	}

	public String getMember_id() {
		return member_id;
	}

	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}

	public String getLocation() {
		return location;
	}

	public void setLocation(String location) {
		this.location = location;
	}

	public ClassBean getClassBean() {
		return classBean;
	}

	public void setClassBean(ClassBean classBean) {
		this.classBean = classBean;
	}

	public double getLatitude() {
		return latitude;
	}

	public void setLatitude(double latitude) {
		this.latitude = latitude;
	}

	public double getLongitude() {
		return longitude;
	}

	public void setLongitude(double longitude) {
		this.longitude = longitude;
	}

	public java.util.Date getPost_date() {
		return post_date;
	}

	public void setPost_date(java.util.Date post_date) {
		this.post_date = post_date;
	}

	public java.util.Date getEnd_date() {
		return end_date;
	}

	public void setEnd_date(java.util.Date end_date) {
		this.end_date = end_date;
	}

	public int getBlock() {
		return block;
	}

	public void setBlock(int block) {
		this.block = block;
	}

	public int getDone() {
		return done;
	}

	public void setDone(int done) {
		this.done = done;
	}

	public String getGetter_id() {
		return getter_id;
	}

	public void setGetter_id(String getter_id) {
		this.getter_id = getter_id;
	}

	public int getGetter_rate() {
		return getter_rate;
	}

	public void setGetter_rate(int getter_rate) {
		this.getter_rate = getter_rate;
	}

	public String getGetter_review() {
		return getter_review;
	}

	public void setGetter_review(String getter_review) {
		this.getter_review = getter_review;
	}

	public int getGiver_rate() {
		return giver_rate;
	}

	public void setGiver_rate(int giver_rate) {
		this.giver_rate = giver_rate;
	}

	public String getGiver_review() {
		return giver_review;
	}

	public void setGiver_review(String giver_review) {
		this.giver_review = giver_review;
	}

	public Set<ImageBean> getImageBean() {
		return imageBean;
	}

	public void setImageBean(Set<ImageBean> imageBean) {
		this.imageBean = imageBean;
	}

	public static void main(String[] args) {
		ApplicationContext context = new ClassPathXmlApplicationContext("beans.config.xml");
		SessionFactory sessionFactory = (SessionFactory) context.getBean("sessionFactory");
		try {
			sessionFactory.getCurrentSession().beginTransaction();
			Session session = sessionFactory.getCurrentSession();

			ItemBean select = (ItemBean) session.get(ItemBean.class, 6);
			System.out.println(select);

			sessionFactory.getCurrentSession().getTransaction().commit();
		} finally {
			sessionFactory.close();
			((ConfigurableApplicationContext) context).close();
		}
	}

}
