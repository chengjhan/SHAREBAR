package member.model;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service(value = "memberService")
@Transactional
public class MemberService {

	// service test
	// public static void main(String[] args) throws IOException {
	// ApplicationContext context;
	// SessionFactory sessionFactory;
	//
	// context = new ClassPathXmlApplicationContext("beans.config.xml");
	// sessionFactory = (SessionFactory) context.getBean("sessionFactory");
	// sessionFactory.getCurrentSession().beginTransaction();
	// MemberService memberService = (MemberService)
	// context.getBean("memberService");
	// // 舊版測試程式
	// MemberBean bean = memberService.login("ianlin2016@outlook.com",
	// "asdfjkl;");
	// System.out.println("bean= " + bean);
	// // memberService.changePassword("ianlin2016@outlook.com", "asdfjkl;",
	// // "aaaaaaaa");
	// // memberService.changeProfile("aaa@gmail.com", "aaa", "AAA", "Hi, I am
	// // AAA");
	// File file = new
	// File("D://Java//workspace_Progect//project_images//jack.jpg");
	// ByteArrayOutputStream ByteArrayOutputStream = null;
	// try {
	// FileInputStream fis = new FileInputStream(file);
	// BufferedInputStream bis = new BufferedInputStream(fis);
	// byte[] contents = new byte[8192];
	// int byteRead = 0;
	// ByteArrayOutputStream = new ByteArrayOutputStream(5000);
	// while ((byteRead = bis.read(contents)) != -1) {
	// ByteArrayOutputStream.write(contents);
	// }
	// } catch (FileNotFoundException e) {
	// // TODO Auto-generated catch block
	// e.printStackTrace();
	// } catch (IOException e) {
	// // TODO Auto-generated catch block
	// e.printStackTrace();
	// }
	// // memberService.changePhoto("aaa@gmail.com", "aaa",
	// // ByteArrayOutputStream.toByteArray());
	//
	// memberService.normalSignUp("ccc@gmail.com", "bbb", "BBB",
	// ByteArrayOutputStream.toByteArray(), "Hi, My name is BBB!");
	//// memberService.readPhotoOfPerson("aaa@gmail.com",
	//// "D://Java//workspace_Progect//project_images//jack_copy.jpg");
	//
	// sessionFactory.getCurrentSession().getTransaction().commit();
	// sessionFactory.close();
	// ((ConfigurableApplicationContext) context).close();
	// }

	@Autowired
	private MemberDAO memberDao;

	@Transactional(readOnly = true)
	public MemberBean login(String member_email, String password) {
		MemberBean bean = memberDao.selectByEmail(member_email);
		if (bean != null) {
			if (password != null && password.length() != 0) {
				String pass = bean.getPassword();
				String temp = password;
				if (temp.equals(pass)) {
					return bean;
				}
			}
		}
		return null;
	}

	@Transactional
	public MemberBean normalSignUp(String member_email, String password, String member_nickname, String photo,
			String description, String last_name, String first_name, String country, String city, String token) {
		MemberBean bean = new MemberBean();
		bean.setEmail(member_email);
		bean.setPassword(password);
		bean.setNickname(member_nickname);
		bean.setPhoto(photo);
		bean.setDescription(description);
		bean.setActivate_token(token);
		bean.setFirst_name(first_name);
		bean.setLast_name(last_name);
		bean.setCity(city);
		bean.setCountry(country);
		bean.setSigndate(new java.util.Date());
		bean.setBlockdate(null);
		// System.out.println("bean= " + bean);
		return memberDao.insert(bean);
	}
	
	@Transactional
	public MemberBean GSignUp(String GId, String email, String nickname,String FirstName, String LastName, String photo, String password){
		MemberBean bean = new MemberBean();
		bean.setEmail(email);
		bean.setPassword("0000");
		bean.setFacebook(GId);
		bean.setNickname(nickname);
		bean.setFirst_name(FirstName);
		bean.setLast_name(LastName);
		bean.setPhoto(photo);
		bean.setSigndate(new java.util.Date());
		bean.setBlockdate(null);
		bean.setCertification(1);
		bean.setPassword(password);
		return memberDao.insert(bean);
	}

	@Transactional
	public MemberBean fbSignUp(String email, String nickname, String facebookID) {
		MemberBean bean = new MemberBean();
		bean.setEmail(email);
		bean.setNickname(nickname);
		bean.setFacebook(facebookID);
		bean.setSigndate(new java.util.Date());
		bean.setBlockdate(null);
		return memberDao.insert(bean);
	}

	@Transactional
	public MemberBean findById(int id) {
		MemberBean bean = null;
		if (id != 0) {
			bean = memberDao.selectByNo(id);
			if (bean != null) {
				return bean;
			}
		}
		return null;
	}

	@Transactional
	public MemberBean findByEmail(String email) {
		MemberBean bean = null;
		if (email != null) {
			bean = memberDao.selectByEmail(email);
			if (bean != null) {
				return bean;
			}
		}
		return null;
	}

	@Transactional
	public MemberBean findByToken(String token) {
		MemberBean bean = null;
		if (token.length() != 0 && token != null) {
			bean = memberDao.selectByToken(token);
		}
		if (bean != null) {
			return bean;
		}
		return null;
	}

	@Transactional
	public MemberBean findByFB(String facebookId) {
		MemberBean bean = null;
		bean = memberDao.selctByFb(facebookId);
		if (bean != null) {
			return bean;
		}
		return null;
	}
	
	@Transactional
	public MemberBean findByG(String Gid_token){
		MemberBean bean = null;
		bean = memberDao.selectByG(Gid_token);
		if(bean!=null){
			return bean;
		}
		return null;
	}

	@Transactional
	public MemberBean updateFb(MemberBean bean) {
		MemberBean update = null;
		update = memberDao.updateFb(bean.getMember_no(), bean.getFacebook());
		if (update != null) {
			return update;
		}
		return null;
	}

	@Transactional
	public boolean activateAccount(String token) {
		int result = memberDao.accountActivate(token);
		if (result == 1) {
			return true;
		}
		return false;
	}

	@Transactional
	public boolean checkAccount(String email) {
		MemberBean bean = memberDao.selectByEmail(email);
		if (bean != null) {
			return true;
		} else {
			return false;
		}
	}

	@Transactional
	public MemberBean update(MemberBean user) {
		MemberBean bean = memberDao.update2(user.getMember_no(), user.getFirst_name(), user.getLast_name(),
				user.getCountry(), user.getCity(), user.getNickname(), user.getDescription(), user.getPhoto());
		if (bean != null) {
			return bean;
		}
		return null;
	}

	@Transactional
	public boolean setBlockDate(MemberBean bean) {
		if (bean != null) {
			bean = memberDao.updateMemberBlock(bean);
			if (bean != null) {
				return true;
			}
		}
		return false;
	}

	@Transactional
	public List<MemberBean> findBlockMember() {
		List<MemberBean> blockmembers = memberDao.selectBlockMember();
		if (blockmembers != null) {
			return blockmembers;
		}
		return null;
	}
}
