package messageBoard.model;

import org.jboss.jandex.Main;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ConfigurableApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import item.model.ItemBean;
import item.model.ItemDAO;
import item.model.ItemService;
import member.model.MemberBean;
import member.model.MemberDAO;
import member.model.MemberService;
import messageBoard.model.dao.MessageBoardDAOhibernate;

@Service(value="messageBoardService")
@Transactional
public class MessageBoardService {
	@Autowired
	private MessageBoardDAOhibernate messageBoardDao;
	
	@Transactional
	public Boolean addmessage(ItemBean itembean,MemberBean memberbean,String text){
		if(itembean != null && memberbean != null && text!= null){
			MessageBoardBean messagebean = new MessageBoardBean(itembean, memberbean, text);
			messageBoardDao.addmessage(messagebean);
			System.out.println("留言新增成功");
			return true;
		}
		else{
			return false;		
		}
	}
	@Transactional
	public Boolean delate(int id,ItemBean itembean,MemberBean memberbean){
		MessageBoardBean check= messageBoardDao.selectById(id);	
		Boolean checkmember = check.getItem_id().getItem_id() == itembean.getItem_id();
		Boolean checkitem =check.getMember_id().getMember_no() == memberbean.getMember_no();
		if (check!=null && checkmember && checkitem){
			messageBoardDao.showSwitch(id);
			System.out.println("data delate");
			return true;
		}
		else {
			System.out.println("data error cant switch show");
			return false;
		}
	}
	@Transactional
	public Boolean edit(int id,ItemBean itembean,MemberBean memberbean,String message){
		MessageBoardBean check = messageBoardDao.selectById(id);
		Boolean checkmember = check.getItem_id().getItem_id() == itembean.getItem_id();
		Boolean checkitem =check.getMember_id().getMember_no() == memberbean.getMember_no();
		
		if(check!=null && checkmember && checkitem){
			check.setMessage(message);
			messageBoardDao.edit(check);
			System.out.println("text edit ok");
			return true;
		}
		else{
			System.out.println("data error cant edit");
			return false;
		}
	}
	
	
	public static void main(String[] args) {
		ApplicationContext context = new ClassPathXmlApplicationContext("beans.config.xml");
		MessageBoardService messageBoardService = (MessageBoardService) context.getBean("messageBoardService");
		MemberService memberservice = (MemberService) context.getBean("memberService");
		ItemService itemservice= (ItemService) context.getBean("itemService");
		
		//獲得itembean、memberbean
		MemberBean memberbean = memberservice.findById(1);
		ItemBean itembean = itemservice.selectById(14);
		
//		//addmessage
//		messageBoardService.addmessage(itembean, memberbean, "我要偷椅子");
		
//		//delate
//		messageBoardService.delate(5, itembean, memberbean);
		
//		//edit
//		messageBoardService.edit(5, itembean, memberbean, "edit test");
		
		
		
		((ConfigurableApplicationContext)context).close();
	}
}
