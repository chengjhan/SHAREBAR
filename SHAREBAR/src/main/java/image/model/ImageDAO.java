package image.model;

import java.util.List;

import item.model.ItemBean;

public interface ImageDAO {

	ImageBean insert(ImageBean bean);

	ImageBean update(int image_id, ItemBean itemBean, String image_photo);

	boolean delete(int image_id);

	List<ImageBean> selectByItem(int item_id);

}