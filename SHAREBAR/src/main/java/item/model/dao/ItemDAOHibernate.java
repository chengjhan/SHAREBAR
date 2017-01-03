package item.model.dao;

import java.util.List;
import java.util.Set;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import category.model.ClassBean;
import image.model.ImageBean;
import item.model.ItemBean;
import item.model.ItemDAO;
import member.model.MemberBean;

@Repository(value = "itemDao")
public class ItemDAOHibernate implements ItemDAO {

	@Autowired
	private SessionFactory sessionFactory;

	public ItemDAOHibernate(SessionFactory sessionFactory) {
		this.sessionFactory = sessionFactory;
	}

	@Override
	public Session getSession() {
		return sessionFactory.getCurrentSession();
	}

	@Override
	public ItemBean insert(ItemBean bean) {
		this.getSession().save(bean);
		return bean;
	}

	@Override
	public ItemBean update(int item_id, String item_name, String item_description, String location, ClassBean classBean,
			double latitude, double longitude, java.util.Date end_date) {
		ItemBean bean = this.getSession().get(ItemBean.class, item_id);
		if (bean != null) {
			bean.setItem_name(item_name);
			bean.setItem_description(item_description);
			bean.setLocation(location);
			bean.setClassBean(classBean);
			bean.setLatitude(latitude);
			bean.setLongitude(longitude);
			bean.setEnd_date(end_date);
		}
		return bean;
	}

	@Override
	public boolean delete(int item_id) {
		ItemBean bean = this.getSession().get(ItemBean.class, item_id);
		if (bean != null) {
			this.getSession().delete(bean);
			return true;
		}
		return false;
	}

	@Override
	public ItemBean selectById(int item_id) {
		return this.getSession().get(ItemBean.class, item_id);
	}

	@Override
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List<ItemBean> selectByName(String item_name) {
		Query query = this.getSession().createQuery(
				"from ItemBean where item_name like :item_name and block=:block and done=:done order by post_date desc");
		query.setParameter("item_name", "%" + item_name + "%");
		query.setParameter("block", 0);
		query.setParameter("done", 0);
		List<ItemBean> list = query.getResultList();
		return list;
	}

	@Override
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List<ItemBean> selectByMember(MemberBean member_id) {
		Query query = this.getSession().createQuery("from ItemBean where member_id=?");
		query.setParameter(0, member_id);
		List<ItemBean> list = query.getResultList();
		return list;
	}

	@Override
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List<ItemBean> selectByClass(int class_id) {
		Query query = this.getSession().createQuery("from ItemBean where class_id=?");
		query.setParameter(0, class_id);
		List<ItemBean> list = query.getResultList();
		return list;
	}

	@Override
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List<ItemBean> selectByLatLng(double southwestLat, double southwestLng, double northeastLat,
			double northeastLng) {
		Query query = this.getSession().createQuery(
				"from ItemBean where (latitude>? and latitude<?) and (longitude>? and longitude<?) and block=? and done=? order by post_date desc");
		query.setParameter(0, southwestLat);
		query.setParameter(1, northeastLat);
		query.setParameter(2, southwestLng);
		query.setParameter(3, northeastLng);
		query.setParameter(4, 0);
		query.setParameter(5, 0);
		List<ItemBean> list = query.getResultList();
		return list;
	}

	@Override
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List<ItemBean> selectByBoundsByName(double southwestLat, double southwestLng, double northeastLat,
			double northeastLng, String item_name) {
		Query query = this.getSession().createQuery(
				"from ItemBean where (latitude>? and latitude<?) and (longitude>? and longitude<?) and block=? and done=? and item_name like :item_name order by post_date desc");
		query.setParameter(0, southwestLat);
		query.setParameter(1, northeastLat);
		query.setParameter(2, southwestLng);
		query.setParameter(3, northeastLng);
		query.setParameter(4, 0);
		query.setParameter(5, 0);
		query.setParameter("item_name", "%" + item_name + "%");
		List<ItemBean> list = query.getResultList();
		return list;
	}
	
	@Override
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List<ItemBean> selectByNew() {
		Query query = this.getSession().createQuery("from ItemBean where block= :block and done = :done order by post_date desc");
		query.setParameter("block", 0);
		query.setParameter("done", 0);
		query.setMaxResults(20);
		List<ItemBean> list = query.getResultList();
		return list;
	}
	
	@Override
	public ItemBean updateGetter(int item_id, MemberBean getterBean){
		ItemBean bean = this.getSession().get(ItemBean.class, item_id);
		bean.setGetter_id(getterBean);
		bean.setDone(1);
		return bean;
	}

	@Override
	public Set<ImageBean> selectByItem(int item_id) {
		Set<ImageBean> set = selectById(item_id).getImageBean();
		return set;
	}
	
	//阿典新增
	//(4)找出黑名單物品
	@SuppressWarnings("unchecked")
	@Override
	public List<ItemBean> selectBlockItem(){
		Query<ItemBean> query=null;
		query = getSession().createQuery(
				"from ItemBean where block = 1 ");
		List<ItemBean> results = query.getResultList();
		if(!results.isEmpty()){
			return results;
		}
		return null;
		
	}
	
	//(8)修改: 將物品進行封鎖  item表         block=1
	@Override
	public ItemBean updateItemBlock(int item_id) {
//		ItemBean bean = (ItemBean)getSession().get(ItemBean.class,  item_id);
//		System.out.println("已進入DAO方法updateItemBlock()");
//			ItemBean bean = new ItemBean();
//			bean.setItem_id(item_id);
//			bean.setBlock(1);
//			this.getSession().update(bean);
//		System.out.println("DAO bean內容 = "+bean+"代入item_id="+item_id);
		
		ItemBean bean = this.getSession().get(ItemBean.class, item_id);
		bean.setBlock(1);
		
		
		return bean;
	}
	
	//(9)修改: 解除物品的封鎖  item表         block=0
	@Override
	public ItemBean clearItemBlock(int item_id) {
		ItemBean bean = this.getSession().get(ItemBean.class,  item_id);
			bean.setBlock(0);	
		return bean;
	}

//	public static void main(String[] args) throws ParseException {
//		ApplicationContext context = new ClassPathXmlApplicationContext("beans.config.xml");
//		SessionFactory sessionFactory = (SessionFactory) context.getBean("sessionFactory");
//		try {
//			sessionFactory.getCurrentSession().beginTransaction();
//
//			ItemDAO itemDao = (ItemDAO) context.getBean("itemDao");
//			ClassDAO classDao = (ClassDAO) context.getBean("classDao");
//			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
//
//			ClassBean selectByIdClassBean = classDao.selectById(1);
//			ItemBean selectByIdItemBean = itemDao.selectById(1);
//
//			// insert
//			ItemBean insertBean = new ItemBean();
//			insertBean.setItem_name("耳機");
//			insertBean.setItem_description("全新iPhone耳機");
//			insertBean.setMember_id("aaa@aaa.com");
//			insertBean.setLocation("台北101");
//			insertBean.setClassBean(selectByIdClassBean);
//			insertBean.setLatitude(25.033903);
//			insertBean.setLongitude(121.564509);
//			insertBean.setPost_date(new java.util.Date());
//			insertBean.setEnd_date(sdf.parse("2016-12-31"));
//			System.out.println(itemDao.insert(insertBean));
//
//			// update
//			System.out.println(itemDao.update(28, "喇叭", "全新喇叭", "台北101", selectByIdClassBean, 25.033903, 121.564509,
//					sdf.parse("2016-12-25")));
//
//			// delete
//			System.out.println(itemDao.delete(28));
//
//			// selectByName
//			for (ItemBean bean : itemDao.selectByName("機")) {
//				System.out.println(bean);
//			}
//
//			// selectByMember
//			for (ItemBean bean : itemDao.selectByMember("bbb@bbb.com")) {
//				System.out.println(bean);
//			}
//
//			// selectByClass
//			for (ItemBean bean : itemDao.selectByClass(3)) {
//				System.out.println(bean);
//			}
//
//			// selectByLatLng
//			for (ItemBean bean : itemDao.selectByLatLng(25.033, 121.543, 25.041, 121.564)) {
//				System.out.println(bean);
//			}
//
//			// selectByBoundsByName
//			for (ItemBean bean : itemDao.selectByBoundsByName(25.031836, 121.555604, 25.034534, 121.558302, "衣寫")) {
//				System.out.println(bean);
//			}
//
//			// selectByItem (Set)
//			for (ImageBean bean : selectByIdItemBean.getImageBean()) {
//				System.out.println(bean);
//			}
//
//			// selectByItem (Set)
//			for (ImageBean bean : itemDao.selectByItem(1)) {
//				System.out.println(bean);
//			}
//
//			sessionFactory.getCurrentSession().getTransaction().commit();
//		} finally {
//			sessionFactory.close();
//			((ConfigurableApplicationContext) context).close();
//		}
//	}

}
