package messageBoard.controller;

import java.io.IOException;
import java.util.Collections;
import java.util.HashSet;
import java.util.Set;

import javax.websocket.OnClose;
import javax.websocket.OnError;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

import org.springframework.beans.factory.annotation.Autowired;

import item.model.ItemBean;
import item.model.ItemService;
import member.model.MemberBean;
import member.model.MemberService;
import messageBoard.model.MessageBoardService;
import net.sf.json.JSONObject;

@ServerEndpoint(value = "/item/MessageBoardWebSocket")
public class messageBoardWebSocket{
	static Set<Session> users = Collections.synchronizedSet(new HashSet<Session>());
	
	@OnOpen
	public void boardOpen(Session user){
		users.add(user);
		System.out.println("WebSocketOpen");
	}
	
	@OnMessage
	public void boardmessage(Session user,String message) throws IOException{
		System.out.println("on message 有觸發");
		System.out.println(users.size());
		JSONObject jmessage = JSONObject.fromObject(message);
		int item_id = (int) jmessage.get("item_id");
		int member_no = (int) jmessage.get("member_no");
		String savemessage = (String) jmessage.get("message");
		
		System.out.println(item_id);
		System.out.println(member_no);
		System.out.println(savemessage);
		
		for(Session session:users){
			session.getBasicRemote().sendText(message);
		}
		
		System.out.println("WebSocket message:"+message);
	}
	
	@OnClose
	public void boardClose(Session user){
		users.remove(user);
		System.out.println("websocket 關閉");
	}
	@OnError
	public void boardError(Throwable t){
		
	}
	
}
