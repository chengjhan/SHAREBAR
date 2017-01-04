package administrator.model;

import java.util.List;

import org.hibernate.Session;

public interface ServiceMailDAO {

	Session getSession();

	List<ServiceMailBean> selectMemberMail(int member_id);

	List<ServiceMailBean> selectAllMail();

	ServiceMailBean insertMail(ServiceMailBean bean);

	ServiceMailBean replyMail(int mail_id, String reply_context);

}