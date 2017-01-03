package administrator.model;

import java.util.List;

import org.hibernate.Session;

public interface ReportDAO {

	Session getSession();

	List<ReportBean> selectAllReport();

	ReportBean insertReport(ReportBean bean);

}