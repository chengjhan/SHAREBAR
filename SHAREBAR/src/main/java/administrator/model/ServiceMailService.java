package administrator.model;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;


@Service(value = "serviceMailService")
@Transactional

public class ServiceMailService {

	@Autowired
	private ServiceMailDAO serviceMailDao;
	
	//(1)選取  會員撈出自己member_id的信件
	@Transactional(readOnly = true)
	public List<ServiceMailBean> selectMemberMail(int member_id) {
		List<ServiceMailBean> result = null;
		
			result = serviceMailDao.selectMemberMail(member_id);
		
		return result;
	}
	
	//(2)選取  GM撈出所有檢舉信件
	@Transactional(readOnly = true)
	public List<ServiceMailBean> selectAllMail() {
		List<ServiceMailBean> result = null;
		
			result = serviceMailDao.selectAllMail();
		
		return result;
	}
	
	//(3)insert 會員寫檢舉信
	@Transactional
	public ServiceMailBean insertMail(ServiceMailBean bean){
		if(bean!=null){
			ServiceMailBean result =serviceMailDao.insertMail(bean);
			return result;
		}
		return null;
	}
	
	
	//(4)insert GM回覆檢舉信
	public ServiceMailBean replyMail(int mail_id ,String reply_context){
		ServiceMailBean result = serviceMailDao.replyMail(mail_id ,reply_context);
		if(result!=null){
			return result;
		}
		return null;
	}
	
	
}
