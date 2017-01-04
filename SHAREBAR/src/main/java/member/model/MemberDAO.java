package member.model;

import java.util.List;

import org.hibernate.Session;

public interface MemberDAO {

	Session getSession();
	// private SessionFactory sessionFactory;
	// public Session getSession(){
	// return sessionFactory.getCurrentSession();
	// }

	// OK
	List<MemberBean> select();

	// OK
	MemberBean normalInsert(MemberBean bean);

	// OK
	MemberBean insert(MemberBean bean);

	// OK
	int accountActivate(String token);

	// OK
	boolean delete(int member_no);

	public MemberBean selectByNo(int member_no);

	public MemberBean selectByEmail(String email);

	public MemberBean selectByToken(String token);

	public MemberBean update2(int member_no, String firstName, String lastName, String country, String city,
			String nickname, String description, String photo);

	public MemberBean update(int member_no, String firstName, String lastName, String country, String city,
			String nickname, String description);

	public MemberBean selctByFb(String facebookId);
	
	public MemberBean updateFb(int member_no, String facebookId);

	public MemberBean updateMemberBlock(MemberBean bean);

	public List<MemberBean> selectBlockMember();

	public MemberBean selectByG(String id_token);

}