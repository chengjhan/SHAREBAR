package category.model.dao;

import java.util.List;
import java.util.Set;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ConfigurableApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Repository;

import category.model.ClassBean;
import category.model.ClassDAO;
import item.model.ItemBean;

@Repository(value = "classDao")
public class ClassDAOHibernate implements ClassDAO {

	@Autowired
	private SessionFactory sessionFactory;

	public ClassDAOHibernate(SessionFactory sessionFactory) {
		this.sessionFactory = sessionFactory;
	}

	public Session getSession() {
		return sessionFactory.getCurrentSession();
	}

	@Override
	public ClassBean insert(ClassBean bean) {
		this.getSession().save(bean);
		return bean;
	}

	@Override
	public ClassBean update(int class_id, String class_name, String image, String icon, String icon_after) {
		ClassBean bean = this.getSession().get(ClassBean.class, class_id);
		if (bean != null) {
			bean.setClass_id(class_id);
			bean.setClass_name(class_name);
			bean.setImage(image);
			bean.setIcon(icon);
			bean.setIcon_after(icon_after);
		}
		return bean;
	}

	@Override
	public boolean delete(int class_id) {
		ClassBean bean = this.getSession().get(ClassBean.class, class_id);
		if (bean != null) {
			this.getSession().delete(bean);
			return true;
		}
		return false;
	}

	@Override
	public ClassBean selectById(int class_id) {
		return this.getSession().get(ClassBean.class, class_id);
	}

	@Override
	@SuppressWarnings("rawtypes")
	public ClassBean selectByName(String class_name) {
		Query query = this.getSession().createQuery("from ClassBean where class_name=?");
		query.setParameter(0, class_name);
		return (ClassBean) query.getSingleResult();
	}

	@Override
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List<ClassBean> selectAll() {
		Query query = this.getSession().createQuery("from ClassBean");
		return (List<ClassBean>) query.getResultList();
	}

	@Override
	public Set<ItemBean> selectByClass(int class_id) {
		Set<ItemBean> set = selectById(class_id).getItemBean();
		return set;
	}
	
	@Override
	public List<ClassBean> selectRandom(){
		Query query = this.getSession().createQuery("from ClassBean order by rand() desc");
		query.setMaxResults(10);
		List<ClassBean> list = query.getResultList();
		if(list!=null){
			return list;
		}
		return null;
	}

	public static void main(String[] args) {
		ApplicationContext context = new ClassPathXmlApplicationContext("beans.config.xml");
		SessionFactory sessionFactory = (SessionFactory) context.getBean("sessionFactory");
		try {
			sessionFactory.getCurrentSession().beginTransaction();

			ClassDAO classDao = (ClassDAO) context.getBean("classDao");
			ClassBean selectByIdClassBean = classDao.selectById(1);

			// delete
			System.out.println(classDao.delete(4));

			// selectById
			System.out.println(selectByIdClassBean);
			
			// selectByName
			System.out.println(classDao.selectByName("3C"));

			// selectAll
			for (ClassBean bean : classDao.selectAll()) {
				System.out.println(bean);
			}

			// selectByClass (Set)
			for (ItemBean bean : selectByIdClassBean.getItemBean()) {
				System.out.println(bean);
			}

			// selectByClass (Set)
			for (ItemBean bean : classDao.selectByClass(1)) {
				System.out.println(bean);
			}

			sessionFactory.getCurrentSession().getTransaction().commit();
		} finally {
			sessionFactory.close();
			((ConfigurableApplicationContext) context).close();
		}
	}

}
