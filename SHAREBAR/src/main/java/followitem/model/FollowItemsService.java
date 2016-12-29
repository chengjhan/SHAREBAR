package followitem.model;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ConfigurableApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import item.model.ItemBean;
import item.model.dao.ItemDAOHibernate;
import member.model.dao.MemberDAOHibernate;


@Service(value="followItemsService")
@Transactional
public class FollowItemsService {
	
	@Autowired
	private FollowItemsDAO followItemsDao;
	@Autowired
	private ItemDAOHibernate itemDAO;
	@Autowired
	private MemberDAOHibernate memberDAO;
	
	@Transactional
	public List<ItemBean> followItemsDetail(int member_no){
		List<ItemBean> itembean =new ArrayList<ItemBean>();
		List<FollowItemsBean> followItemsBean =  followItemsDao.select(member_no);
		
		for(int i=0 ;i < followItemsBean.size() ; i++ ){
			itembean.add(followItemsBean.get(i).getItemBean());
		}		
		System.out.println(itembean.size());
		return itembean;
	}
	
	public List<FollowItemsBean> followItemBeansDetail(int member_id){
		return followItemsDao.select(member_id);
	}
	
	@Transactional
	public int followItem(int member_no,int item_id){
		FollowItemsBean CheckFollowerItem = followItemsDao.select(member_no, item_id);
		if(null == CheckFollowerItem){
			FollowItemsBean savebean = new FollowItemsBean();
			
			savebean.setMember_id(memberDAO.selectByNo(member_no));
			savebean.setItemBean(itemDAO.selectById(item_id));
			savebean.setStatus(1);
			followItemsDao.insert(savebean);
			System.out.println("新增成功"+ savebean);
			return 1;
		}
		else {
			int result = followItemsDao.update(member_no, item_id);
			System.out.println("更新成功");
			return  result;
		}
	}
	
	public int followStatus(int member_no,int item_id){
		FollowItemsBean checkbean = followItemsDao.select(member_no, item_id);
		if(null!=checkbean){
			int hasFollow = checkbean.getStatus();
			return hasFollow;	
		}
		return 0;
	}
	
	
	
	
	/****************測試******************/
	public static void main(String[] args) {
		ApplicationContext context = new ClassPathXmlApplicationContext("beans.config.xml");
		FollowItemsService followItemsService = (FollowItemsService) context.getBean("followItemsService");
		
//		//FollowerItemStatus
//		followItemsService.FollowerItem(5, 27);
		
		//FollowerItemsDetail
		System.out.println(followItemsService.followItemsDetail(5));
		
		((ConfigurableApplicationContext)context).close();
	}
}

