package message.controller;

import java.io.IOException;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import javax.websocket.CloseReason;
import javax.websocket.OnClose;
import javax.websocket.OnError;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.PathParam;
import javax.websocket.server.ServerEndpoint;

import net.sf.json.JSONObject;

@ServerEndpoint("/websocket/{user_id}")
public class ChatServer {

	private Session session;
	private static final Map<String, ChatServer> 
	connections = new ConcurrentHashMap<String, ChatServer>();

	@OnOpen
	public void open(Session session, @PathParam("user_id") String user_id) {
		this.session = session;
		connections.put(user_id, this);
	}

	/**
	 * @category 接受客户端的消息，并把消息发送给所有连接的会话
	 * @param message
	 *            客户端发来的消息
	 * @param session
	 *            客户端的会话
	 */
	@OnMessage
	public void getMessage(String message) throws IOException{
		
		JSONObject jsonObject = JSONObject.fromObject(message);
		
		//讀取資料
		Integer speaker_id = (Integer) jsonObject.get("speaker") ;
		System.out.println(speaker_id);
		Integer listener_id = (Integer) jsonObject.get("listener");
		System.out.println(listener_id);
//		Integer item_id = (Integer) jsonObject.get("item") ;
//		String content = Integer.toString((int) jsonObject.get("content"));
//		System.out.println(content);
				
		//送出客戶端
		connections.get(Integer.toString(speaker_id)).session.getBasicRemote().sendText(message);
		if(null!=connections.get(Integer.toString(listener_id)))
		connections.get(Integer.toString(listener_id)).session.getBasicRemote().sendText(message);

		//寫入資料庫
//		MemberDAOHibernate memberDAO = new MemberDAOHibernate();
//		ItemDAOHibernate itemDAO = new ItemDAOHibernate();
//		MessageContextDAO messageContextDAO = new MessageContextDAO();
//		MessageContextBean bean = new MessageContextBean();
//		bean.setItemBean(itemDAO.select(item_id));		
//		bean.setMemberBean_speaker(memberDAO.select(speaker_id));
//		bean.setMemberBean_listener(memberDAO.select(listener_id));
//		bean.setTime( new java.util.Date() );
//		bean.setContext(content);
//		messageContextDAO.insert(bean);
	}

	/**
	 * @category 添加关闭会话时的操作
	 * @param reason
	 */
	@OnClose
	public void close(CloseReason reason) {
		connections.remove(this);
	}

	/**
	 * @category 添加处理错误的操作
	 * @param t
	 */
	@OnError
	public void error(Throwable t, Session session) {
		System.out.println(t.getMessage());
		System.out.println("Error");
		}
}