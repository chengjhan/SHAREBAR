package followitem.model;

import java.util.List;

public interface FollowItemsDAO {
	List<FollowItemsBean> select (int member_no);
	
	FollowItemsBean select (int member_no,int item_id);
	
	FollowItemsBean insert (FollowItemsBean followitembean);
	
	int update(int member_no,int item_id);
	
	boolean delate(int member_no,int item_id);
	
	
}
