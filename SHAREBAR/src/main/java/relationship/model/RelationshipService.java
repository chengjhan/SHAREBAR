package relationship.model;

import java.io.IOException;
import java.util.List;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ConfigurableApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import member.model.MemberBean;

@Service(value = "relationshipService")
@Transactional
public class RelationshipService {

	@Autowired
	private RelationshipDAO relationshipDao;

//	public static void main(String[] args) throws IOException {
//		ApplicationContext context;
//		SessionFactory sessionFactory;
//
//		context = new ClassPathXmlApplicationContext("beans.config.xml");
//		sessionFactory = (SessionFactory) context.getBean("sessionFactory");
//		sessionFactory.getCurrentSession().beginTransaction();
//		RelationshipService relationshipService = (RelationshipService) context.getBean("relationshipService");
//		// MemberDAO mdao = new MemberDAOHibernate();
//		// MemberBean mb1 = new MemberBean();
//		// mb1.setMember_no(19);
//		// MemberBean mb2 = new MemberBean();
//		// mb2.setMember_no(13);
//		// System.out.println(mb1);
//		// System.out.println(mb2);
//		// System.out.println(relationshipService.addFollow(mb1,mb2));
//
//		sessionFactory.getCurrentSession().getTransaction().commit();
//		sessionFactory.close();
//		((ConfigurableApplicationContext) context).close();
//	}

	@Transactional
	public boolean changeFollow(MemberBean follow, MemberBean followed, String status) {
		if (follow != null && followed != null) {
			RelationshipBean relation = relationshipDao.selectByBean(follow, followed);
			boolean result = false;
			if (relation != null) {
				System.out.println("do update");
				System.out.println("origin status: "+status);
				if (status.equals("follow")) {
					System.out.println("status= follow");
					result = relationshipDao.update(follow, "unfollow", followed);
				} else if (status.equals("unfollow")) {
					System.out.println("status= unfollow");
					result = relationshipDao.update(follow, "follow", followed);
				}else{
					System.out.println("status != follow and != unfollow");
				}
				if (result) {
					return true;
				}
			} else {
				System.out.println("do insert");
				relation = new RelationshipBean();
				relation.setMember_follow(follow);
				relation.setMember_followed(followed);
				relation.setRelation("follow");
//				if (status == "follow") {
//					relation.setRelation("unfollow");
//				} else if (status == "unfollow") {
//					relation.setRelation("follow");
//				}
				relation = relationshipDao.insert(relation);
				if(relation != null){
					return true;
				}
			}
			// relation.setMember_follow(follow);
			// relation.setMember_followed(followed);
			// if(status == "follow"){
			// relation.setRelation("unfollow");
			// }else if(status == "unfollow"){
			// relation.setRelation("follow");
			// }else{
			// relation.setRelation("follow");
			// }
			// relation = relationshipDao.insert(relation);
			// if (relation != null) {
			// System.out.println("relation != null");
			// return true;
			// }
		}
		return false;

	}

	@Transactional
	public String checkRel(MemberBean mb, MemberBean check) {
		RelationshipBean relation = null;
		if (mb != null && mb != null) {
			relation = relationshipDao.selectByBean(mb, check);
			if (relation != null) {
				return relation.getRelation();
			}
		}
		return null;
	}

	@Transactional
	public List<RelationshipBean> findFollow(MemberBean mb) {
		List<RelationshipBean> results;
		if (mb != null) {
			results = relationshipDao.selectByFollow(mb);
			if (!results.isEmpty()) {
				return results;
			}
		}
		return null;
	}

}
