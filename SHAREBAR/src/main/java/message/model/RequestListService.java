package message.model;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service(value="requestListService")
@Transactional
public class RequestListService {
	
	@Autowired
	private RequestListDAO requestListDAO;
	
	@Transactional
	public String askConsent(int item_id, int requester_id){
		requestListDAO.asking(item_id, requester_id);
		return requestListDAO.checkStatus(item_id, requester_id);
	}
	@Transactional
	public String aceptDemand(int item_id, int requester_id){
		requestListDAO.acepted(item_id, requester_id);
		return requestListDAO.checkStatus(item_id, requester_id);
	}
	@Transactional
	public String refuseDemand(int item_id, int requester_id){
		requestListDAO.refused(item_id, requester_id);
		return requestListDAO.checkStatus(item_id, requester_id);
	}
}
