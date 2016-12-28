package image.model;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ConfigurableApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import item.model.ItemBean;

@Service(value = "imageService")
@Transactional
public class ImageService {

	@Autowired
	private ImageDAO imageDao;

	@Transactional
	public ImageBean insert(ImageBean bean) {
		ImageBean result = null;
		if (bean != null) {
			result = imageDao.insert(bean);
		}
		return result;
	}

	@Transactional
	public ImageBean update(ImageBean bean) {
		ImageBean result = null;
		if (bean != null) {
			result = imageDao.update(bean.getImage_id(), bean.getItemBean(), bean.getImage_photo());
		}
		return result;
	}

	@Transactional
	public boolean delete(ImageBean bean) {
		boolean result = false;
		if (bean != null) {
			result = imageDao.delete(bean.getImage_id());
		}
		return result;
	}

	@Transactional(readOnly = true)
	public List<ImageBean> select(ImageBean bean) {
		List<ImageBean> result = null;
		if (bean != null) {
			result = imageDao.selectByItem(bean.getItemBean().getItem_id());
		}
		return result;
	}

	public static void main(String[] args) {
		ApplicationContext context = new ClassPathXmlApplicationContext("beans.config.xml");
		
		ImageService imageService = (ImageService) context.getBean("imageService");

		// selectByItem
		ImageBean selectByItemBean = new ImageBean();
		ItemBean selectByItemItemBean = new ItemBean();
		selectByItemItemBean.setItem_id(1);
		selectByItemBean.setItemBean(selectByItemItemBean);
		for (ImageBean bean : imageService.select(selectByItemBean)) {
			System.out.println(bean);
		}

		((ConfigurableApplicationContext) context).close();
	}

}
