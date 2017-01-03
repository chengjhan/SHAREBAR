package message.model;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import member.model.MemberBean;

@Service(value="messageContextService")
@Transactional
public class MessageContextService {
	
	@Autowired
	private MessageContextDAO messageContextDAO;
		
		@Transactional
		public List<MessageContextBean> select(int item_id, int requester_id){
			return messageContextDAO.select(item_id, requester_id);
		}
		
		@Transactional
		public List<Object[]> mailForShare(int member_id){
			return messageContextDAO.mailForShare(member_id);
		}
		
		@Transactional
		public List<Object[]> mailForRequest(int member_id){
			return messageContextDAO.mailForRequest(member_id);
		}
		
		@Transactional
		public int mailUnreaded(int member_id){
			return messageContextDAO.mailUnreaded(member_id);
		}
		
		@Transactional
		public void mailReaded(int item_id, int speaker_id, int listener_id){
			messageContextDAO.mailReaded(item_id, speaker_id, listener_id);
		}
		
		@Transactional
		public void insert(MessageContextBean bean){
			messageContextDAO.insert(bean);
		}
}
