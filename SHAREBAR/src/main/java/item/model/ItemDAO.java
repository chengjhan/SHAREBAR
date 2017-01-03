package item.model;

import java.util.List;
import java.util.Set;

import org.hibernate.Session;

import category.model.ClassBean;
import image.model.ImageBean;
import item.model.ItemBean;

public interface ItemDAO {

	Session getSession();

	ItemBean insert(ItemBean bean);

	ItemBean update(int item_id, String item_name, String item_description, String location, ClassBean classBean,
			double latitude, double longitude, java.util.Date end_date);

	boolean delete(int item_id);

	ItemBean selectById(int item_id);

	List<ItemBean> selectByName(String item_name);

	List<ItemBean> selectByMember(String member_id);

	List<ItemBean> selectByClass(int class_id);

	List<ItemBean> selectByLatLng(double southwestLat, double southwestLng, double northeastLat, double northeastLng);

	List<ItemBean> selectByBoundsByName(double southwestLat, double southwestLng, double northeastLat,
			double northeastLng, String item_name);
	
	List<ItemBean> selectByNew();

	Set<ImageBean> selectByItem(int item_id);

}