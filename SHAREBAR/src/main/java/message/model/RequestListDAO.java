package message.model;

import org.hibernate.Session;

import message.model.RequestListBean;

public interface RequestListDAO {

	Session getSession();

	RequestListBean select(int item_id, int requester_id);

	String checkStatus(int item_id, int requester_id);

	void asking(int item_id, int requester_id);

	void refused(int item_id, int requester_id);

	void acepted(int item_id, int requester_id);

}