package item.model;

import java.util.List;
import java.util.Set;

import org.hibernate.Session;

import category.model.ClassBean;
import image.model.ImageBean;
import item.model.ItemBean;
import member.model.MemberBean;

public interface ItemDAO {

	Session getSession();

	ItemBean insert(ItemBean bean);

	ItemBean update(int item_id, String item_name, String item_description, String location, ClassBean classBean,
			double latitude, double longitude, java.util.Date end_date);

	boolean delete(int item_id);

	ItemBean selectById(int item_id);

	List<ItemBean> selectByName(String item_name);

//	List<ItemBean> selectByMember(String member_id);

	List<ItemBean> selectByClass(int class_id);

	List<ItemBean> selectByLatLng(double southwestLat, double southwestLng, double northeastLat, double northeastLng);

	List<ItemBean> selectByBoundsByName(double southwestLat, double southwestLng, double northeastLat,
			double northeastLng, String item_name);
	
	List<ItemBean> selectByNew();
	
	ItemBean updateGetter(int item_id, MemberBean getterBean);

	Set<ImageBean> selectByItem(int item_id);

	List<ItemBean> selectByMember(MemberBean member_id);

	List<ItemBean> selectBlockItem();

	ItemBean updateItemBlock(int item_id);

	ItemBean clearItemBlock(int item_id);

	void rateToGiver(int item_id, int giver_rate, String giver_review);

	void rateToGetter(int item_id, int getter_rate, String getter_review);

}