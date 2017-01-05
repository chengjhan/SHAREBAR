package message.model;

import java.util.List;

import org.hibernate.Session;

import member.model.MemberBean;
import message.model.MessageContextBean;

public interface MessageContextDAO {

	Session getSession();

	MessageContextBean select(int id);

	List<MessageContextBean> select(int id, int member);

	List<Object[]> mailForShare(int member);

	List<Object[]> mailForRequest(int member);

	void insert(MessageContextBean bean);

	int mailUnreaded(int member_id);

	void mailReaded(int item_id, int speaker_id, int listener_id);
	

}