package category.model;

import java.util.ArrayList;
import java.util.List;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ConfigurableApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import item.model.ItemBean;

@Service(value = "classService")
@Transactional
public class ClassService {

	@Autowired
	private ClassDAO classDao;

	@Transactional
	public ClassBean insert(ClassBean bean) {
		ClassBean result = null;
		if (bean != null) {
			result = classDao.insert(bean);
		}
		return result;
	}

	@Transactional
	public ClassBean update(ClassBean bean) {
		ClassBean result = null;
		if (bean != null) {
			result = classDao.update(bean.getClass_id(), bean.getClass_name(), bean.getImage());
		}
		return result;
	}

	@Transactional
	public boolean delete(ClassBean bean) {
		boolean result = false;
		if (bean != null) {
			result = classDao.delete(bean.getClass_id());
		}
		return result;
	}

	@Transactional
	public ClassBean selectById(ClassBean bean) {
		ClassBean result = null;
		if (bean != null) {
			result = classDao.selectById(bean.getClass_id());
		}
		return result;
	}

	@Transactional
	public ClassBean selectByName(ClassBean bean) {
		ClassBean result = null;
		if (bean != null) {
			result = classDao.selectByName(bean.getClass_name());
		}
		return result;
	}

	@Transactional(readOnly = true)
	public List<ClassBean> select(ClassBean bean) {
		List<ClassBean> result = null;
		if (bean != null && bean.getClass_id() != 0) {
			ClassBean aBean = classDao.selectById(bean.getClass_id());
			if (aBean != null) {
				result = new ArrayList<ClassBean>();
				result.add(aBean);
			}
		} else {
			result = classDao.selectAll();
		}
		return result;
	}

	@Transactional(readOnly = true)
	public Set<ItemBean> selectByClass(ClassBean bean) {
		Set<ItemBean> result = null;
		if (bean != null) {
			result = classDao.selectByClass(bean.getClass_id());
		}
		return result;
	}

	public static void main(String[] args) {
		ApplicationContext context = new ClassPathXmlApplicationContext("beans.config.xml");

		ClassService classService = (ClassService) context.getBean("classService");
		ClassBean selectByIdBean = new ClassBean();
		selectByIdBean.setClass_id(1);

		// selectById
		System.out.println(classService.select(selectByIdBean));

		// selectAll
		for (ClassBean bean : classService.select(null)) {
			System.out.println(bean);
		}

		// selectById (Set)
		for (ItemBean bean : classService.selectByClass(selectByIdBean)) {
			System.out.println(bean);
		}

		((ConfigurableApplicationContext) context).close();
	}

}
