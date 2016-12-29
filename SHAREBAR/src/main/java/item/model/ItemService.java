package item.model;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.List;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ConfigurableApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import category.model.ClassBean;
import category.model.ClassService;
import image.model.ImageBean;

@Service(value = "itemService")
@Transactional
public class ItemService {

	@Autowired
	private ItemDAO itemDao;

	@Transactional
	public ItemBean insert(ItemBean bean) {
		ItemBean result = null;
		if (bean != null) {
			result = itemDao.insert(bean);
		}
		return result;
	}

	@Transactional
	public ItemBean update(ItemBean bean) {
		ItemBean result = null;
		if (bean != null) {
			result = itemDao.update(bean.getItem_id(), bean.getItem_name(), bean.getItem_description(),
					bean.getLocation(), bean.getClassBean(), bean.getLatitude(), bean.getLongitude(),
					bean.getEnd_date());
		}
		return result;
	}

	@Transactional
	public boolean delete(ItemBean bean) {
		boolean result = false;
		if (bean != null) {
			result = itemDao.delete(bean.getItem_id());
		}
		return result;
	}

	@Transactional
	public ItemBean selectById(int item_id) {
		ItemBean result = null;
		if (item_id != 0) {
			result = itemDao.selectById(item_id);
		}
		return result;
	}

	@Transactional(readOnly = true)
	public List<ItemBean> selectByName(ItemBean bean) {
		List<ItemBean> result = null;
		if (bean != null) {
			result = itemDao.selectByName(bean.getItem_name());
		}
		return result;
	}

	@Transactional(readOnly = true)
	public List<ItemBean> selectByMember(ItemBean bean) {
		List<ItemBean> result = null;
		if (bean != null) {
			result = itemDao.selectByMember(bean.getMember_id());
		}
		return result;
	}

	@Transactional(readOnly = true)
	public List<ItemBean> selectByClass(ItemBean bean) {
		List<ItemBean> result = null;
		if (bean != null) {
			result = itemDao.selectByClass(bean.getClassBean().getClass_id());
		}
		return result;
	}

	@Transactional(readOnly = true)
	public List<ItemBean> selectByLatLng(double southwestLat, double southwestLng, double northeastLat,
			double northeastLng) {
		List<ItemBean> result = null;
		result = itemDao.selectByLatLng(southwestLat, southwestLng, northeastLat, northeastLng);
		return result;
	}

	@Transactional(readOnly = true)
	public List<ItemBean> selectByBoundsByName(double southwestLat, double southwestLng, double northeastLat,
			double northeastLng, String item_name) {
		List<ItemBean> result = null;
		result = itemDao.selectByBoundsByName(southwestLat, southwestLng, northeastLat, northeastLng, item_name);
		return result;
	}

	@Transactional(readOnly = true)
	public Set<ImageBean> selectByItem(ItemBean bean) {
		Set<ImageBean> result = null;
		if (bean != null) {
			result = itemDao.selectByItem(bean.getItem_id());
		}
		return result;
	}

	// 阿典新增 搜尋黑名單物品
	@Transactional(readOnly = true)
	public List<ItemBean> selectBlockItem() {
		List<ItemBean> results = null;
		results = itemDao.selectBlockItem();
		if (results != null) {
			return results;
		}
		return null;
	}

	// 阿典新增 將物品進行封鎖
	@Transactional
	public ItemBean updateItemBlock(int item_id) {
		ItemBean selectById = itemDao.selectById(item_id);
		if (selectById != null) {
			if (item_id != 0) {
				ItemBean result = null;
				result = itemDao.updateItemBlock(item_id);
				return result;
			}
		}
		return null;
	}

	// 阿典新增 解除物品的封鎖
	@Transactional
	public ItemBean clearItemBlock(int item_id) {

		ItemBean selectById = itemDao.selectById(item_id);
		if (selectById != null) {
			if (item_id != 0) {
				ItemBean result = null;
				result = itemDao.clearItemBlock(item_id);
				return result;
			}
		}
		return null;
	}

	// public static void main(String[] args) throws ParseException {
	// ApplicationContext context = new
	// ClassPathXmlApplicationContext("beans.config.xml");
	//
	// ItemService itemService = (ItemService) context.getBean("itemService");
	// ClassService classService = (ClassService)
	// context.getBean("classService");
	// SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	//
	// // insert
	// ItemBean insertBean = new ItemBean();
	// insertBean.setItem_name("耳機");
	// insertBean.setItem_description("全新iPhone耳機");
	// insertBean.setMember_id("aaa@aaa.com");
	// insertBean.setLocation("台北101");
	// ClassBean insertClassBean = new ClassBean();
	// insertClassBean.setClass_id(3);
	// ClassBean selectByIdBean = classService.selectById(insertClassBean);
	// insertBean.setClassBean(selectByIdBean);
	// insertBean.setLatitude(25.033903);
	// insertBean.setLongitude(121.564509);
	// insertBean.setPost_date(new java.util.Date());
	// insertBean.setEnd_date(sdf.parse("2016-12-20"));
	// System.out.println(itemService.insert(insertBean));
	//
	// // update
	// ItemBean updateBean = new ItemBean();
	// updateBean.setItem_id(29);
	// updateBean.setItem_name("電視");
	// updateBean.setItem_description("全新iPhone耳機");
	// updateBean.setMember_id("aaa@aaa.com");
	// updateBean.setLocation("台北101");
	// ClassBean updateClassBean = new ClassBean();
	// updateClassBean.setClass_id(3);
	// updateBean.setClassBean(updateClassBean);
	// updateBean.setLatitude(25.033903);
	// updateBean.setLongitude(121.564509);
	// updateBean.setEnd_date(sdf.parse("2016-12-25"));
	// System.out.println(itemService.update(updateBean));
	//
	// // delete
	// ItemBean deleteBean = new ItemBean();
	// deleteBean.setItem_id(4);
	// System.out.println(itemService.delete(deleteBean));
	//
	// // selectByName
	// ItemBean selectByNameBean = new ItemBean();
	// selectByNameBean.setItem_name("機");
	// for (ItemBean bean : itemService.selectByName(selectByNameBean)) {
	// System.out.println(bean);
	// }
	//
	// // selectByMember
	// ItemBean selectByMemberBean = new ItemBean();
	// selectByMemberBean.setMember_id("aaa@aaa.com");
	// for (ItemBean bean : itemService.selectByMember(selectByMemberBean)) {
	// System.out.println(bean);
	// }
	//
	// // selectByClass
	// ItemBean selectByClassBean = new ItemBean();
	// ClassBean selectByClassClassBean = new ClassBean();
	// selectByClassClassBean.setClass_id(4);
	// selectByClassBean.setClassBean(selectByClassClassBean);
	// for (ItemBean bean : itemService.selectByClass(selectByClassBean)) {
	// System.out.println(bean);
	// }
	//
	// // selectByLatLng
	// for (ItemBean bean : itemService.selectByLatLng(25.033, 121.543, 25.041,
	// 121.564)) {
	// System.out.println(bean);
	// }
	//
	// // selectByBoundsByName
	// for (ItemBean bean : itemService.selectByBoundsByName(25.031836,
	// 121.555604, 25.034534, 121.558302, "衣寫")) {
	// System.out.println(bean);
	// }
	//
	// // selectByItem (Set)
	// ItemBean selectByItemItemBean = new ItemBean();
	// selectByItemItemBean.setItem_id(4);
	// for (ImageBean bean : itemService.selectByItem(selectByItemItemBean)) {
	// System.out.println(bean);
	// }
	//
	// ((ConfigurableApplicationContext) context).close();
	// }

}
