package category.model;

import java.util.List;
import java.util.Set;

import item.model.ItemBean;

public interface ClassDAO {

	ClassBean insert(ClassBean bean);

	ClassBean update(int class_id, String class_name, String image, String icon, String icon_after);

	boolean delete(int class_id);

	ClassBean selectById(int class_id);

	ClassBean selectByName(String class_name);

	List<ClassBean> selectAll();

	Set<ItemBean> selectByClass(int class_id);

	List<ClassBean> selectRandom();

}