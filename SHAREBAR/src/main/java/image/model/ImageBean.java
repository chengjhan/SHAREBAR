package image.model;

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

import com.google.gson.annotations.Expose;

import item.model.ItemBean;

@Entity
@Table(name = "image", catalog = "test3", schema = "dbo")
public class ImageBean {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Expose
	private int image_id;
	@ManyToOne
	@JoinColumn(name = "item_id")
	@Expose(serialize = false)
	private ItemBean itemBean;
	@Expose
	private String image_photo;

	@Override
	public String toString() {
		return "ImageBean [image_id=" + image_id + ", image_photo=" + image_photo + "]";
	}

	public int getImage_id() {
		return image_id;
	}

	public void setImage_id(int image_id) {
		this.image_id = image_id;
	}

	public ItemBean getItemBean() {
		return itemBean;
	}

	public void setItemBean(ItemBean itemBean) {
		this.itemBean = itemBean;
	}

	public String getImage_photo() {
		return image_photo;
	}

	public void setImage_photo(String image_photo) {
		this.image_photo = image_photo;
	}

	public static void main(String[] args) {
		ApplicationContext context = new ClassPathXmlApplicationContext("beans.config.xml");
		SessionFactory sessionFactory = (SessionFactory) context.getBean("sessionFactory");
		try {
			sessionFactory.getCurrentSession().beginTransaction();
			Session session = sessionFactory.getCurrentSession();

			ImageBean select = (ImageBean) session.get(ImageBean.class, 1);
			System.out.println(select);

			sessionFactory.getCurrentSession().getTransaction().commit();
		} finally {
			sessionFactory.close();
			((ConfigurableApplicationContext) context).close();
		}
	}

}
