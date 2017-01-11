package member.controller;

import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import member.model.MemberBean;


@WebServlet("/member/updateProfilePhoto.do")
public class UpdatePhotoServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UpdatePhotoServlet() {
        super();
        // TODO Auto-generated constructor stub
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doPost(request,response);
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setHeader("content-type", "text/html:charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		Map<String, String> errors = new HashMap<String, String>();
		request.setAttribute("errors", errors);
		String rootpath = request.getServletContext().getRealPath("/profileImages/");//get web app root directory
		String imageData = request.getParameter("image-data");
		
		if(imageData==null || imageData.trim().length()==0){
			errors.put("photo", "photo is required.");
		}
		if(errors!=null && !errors.isEmpty()) {
			request.getRequestDispatcher(
					"/member/changeInfo.jsp").forward(request, response);
			return;
		}
		
		MemberBean userBean = (MemberBean)request.getSession().getAttribute("user");	
		try {
			String base64Image = imageData.split(",")[1];
			byte[] imageBytes = javax.xml.bind.DatatypeConverter.parseBase64Binary(base64Image);
			ByteArrayInputStream bis = new ByteArrayInputStream(imageBytes);
			BufferedImage bufImg = ImageIO.read(bis);
			bis.close();
			File imgOutFile = new File(rootpath+userBean.getPhoto());
			ImageIO.write(bufImg, "png", imgOutFile);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			errors.put("system", "writing file error");
		}
		
		if(errors!=null && !errors.isEmpty()) {
			request.getRequestDispatcher(
					"/member/changeInfo.jsp").forward(request, response);
			return;
		}else{
			String path = request.getContextPath();
			response.sendRedirect(path+"/member/userProfile.jsp");
		}
		
	}

}
