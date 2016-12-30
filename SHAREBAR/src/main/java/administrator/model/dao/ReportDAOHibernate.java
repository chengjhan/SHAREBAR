package administrator.model.dao;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import administrator.model.ReportBean;
import administrator.model.ReportDAO;


@Repository(value="reportDAO")
@Transactional
public class ReportDAOHibernate implements ReportDAO  {

	
	@Autowired
	private SessionFactory sessionFactory;

	public ReportDAOHibernate(SessionFactory sessionFactory) {
		this.sessionFactory = sessionFactory;
	}

	@Override
	public Session getSession() {
		return sessionFactory.getCurrentSession();
	}
	
	
	//(5)選取所有report表的資料
	@Override
	@SuppressWarnings("unchecked")
	public List<ReportBean> selectAllReport(){
		Query<ReportBean> query = this.getSession().createQuery(
				"from ReportBean"); 	
				//"from ReportBean order by reported_item_id"
		return query.getResultList();
	}
	
	//(5-2)新增 report表的資料
	@Override
	public ReportBean insertReport(ReportBean bean){
		this.getSession().save(bean);
		return bean;
	}
	
	
}
