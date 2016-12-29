package administrator.model;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service(value = "reportService")
@Transactional
public class ReportService {

	@Autowired
	private ReportDAO reportDao;
	
	//(5)選取所有report表的資料
	@Transactional
	public List<ReportBean> selectAllReport(){
		List<ReportBean> result =reportDao.selectAllReport();
		System.out.println("result="+result);
		return result;
	}
	
	//(5-2)新增 report表的資料
	@Transactional
	public ReportBean insertReport(ReportBean bean){
		if(bean!=null){
			ReportBean result =reportDao.insertReport(bean);
			return result;
			
		}
		return null;
	}
	
	
}
