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
public class ChatServer{
	
	private Session session;
	private static final Map<String, ChatServer> 
	connections = new ConcurrentHashMap<String, ChatServer>();

	@OnOpen
	public void open(Session session, @PathParam("user_id") String user_id) {
		this.session = session;
		connections.put(user_id, this);
		System.out.println("系統：WebSocket新增Session：" + user_id);
	}

	@OnMessage
	public void getMessage(String message) throws IOException{
		
		JSONObject jsonObject = JSONObject.fromObject(message);
		
		//讀取資料
		Integer speaker_id = (Integer) jsonObject.get("speaker") ;		
		Integer listener_id = (Integer) jsonObject.get("listener");		
		System.out.println("系統:已接收訊息");				
		//送出客戶端
		connections.get(Integer.toString(speaker_id)).session.getBasicRemote().sendText(message);
		if(null!=connections.get(Integer.toString(listener_id)))
		connections.get(Integer.toString(listener_id)).session.getBasicRemote().sendText(message);
	}

	@OnClose
	public void close(CloseReason reason) {
		connections.remove(this);
	}

	@OnError
	public void error(Throwable t, Session session) {
		System.out.println("系統錯誤：" + t.getMessage());
		}
}