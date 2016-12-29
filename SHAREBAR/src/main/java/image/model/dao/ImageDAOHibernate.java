package image.model.dao;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ConfigurableApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Repository;

import image.model.ImageBean;
import image.model.ImageDAO;
import item.model.ItemBean;

@Repository(value = "imageDao")
public class ImageDAOHibernate implements ImageDAO {

	@Autowired
	private SessionFactory sessionFactory;

	public ImageDAOHibernate(SessionFactory sessionFactory) {
		this.sessionFactory = sessionFactory;
	}

	public Session getSession() {
		return sessionFactory.getCurrentSession();
	}

	@Override
	public ImageBean insert(ImageBean bean) {
		this.getSession().save(bean);
		return bean;
	}

	@Override
	public ImageBean update(int image_id, ItemBean itemBean, String image_photo) {
		ImageBean bean = this.getSession().get(ImageBean.class, image_id);
		if (bean != null) {
			bean.setImage_id(image_id);
			bean.setItemBean(itemBean);
			bean.setImage_photo(image_photo);
		}
		return bean;
	}

	@Override
	public boolean delete(int image_id) {
		ImageBean bean = this.getSession().get(ImageBean.class, image_id);
		if (bean != null) {
			this.getSession().delete(bean);
			return true;
		}
		return false;
	}

	@Override
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List<ImageBean> selectByItem(int item_id) {
		Query query = this.getSession().createQuery("from ImageBean where item_id=?");
		query.setParameter(0, item_id);
		List<ImageBean> list = query.getResultList();
		return list;
	}

	public static void main(String[] args) {
		ApplicationContext context = new ClassPathXmlApplicationContext("beans.config.xml");
		SessionFactory sessionFactory = (SessionFactory) context.getBean("sessionFactory");
		try {
			sessionFactory.getCurrentSession().beginTransaction();
			
			ImageDAO imageDao = (ImageDAO) context.getBean("imageDao");

			// delete
			System.out.println(imageDao.delete(8));

			// selectByItem
			for (ImageBean bean : imageDao.selectByItem(1)) {
				System.out.println(bean);
			}

			sessionFactory.getCurrentSession().getTransaction().commit();
		} finally {
			sessionFactory.close();
			((ConfigurableApplicationContext) context).close();
		}
	}

}
