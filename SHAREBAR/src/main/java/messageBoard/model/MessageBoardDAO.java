package messageBoard.model;

import java.util.List;

public interface MessageBoardDAO {
	
	Boolean addmessage(MessageBoardBean messageboardbean);

	Boolean edit(MessageBoardBean messageboardbean);

	int showSwitch(int id);
	
	List<String> selectByItemid(int item_id);
	
	MessageBoardBean selectById(int id);
}
