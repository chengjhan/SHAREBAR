package item.controller;

import java.io.IOException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.xpath.XPath;
import javax.xml.xpath.XPathConstants;
import javax.xml.xpath.XPathExpression;
import javax.xml.xpath.XPathFactory;

import org.springframework.context.ApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;
import org.w3c.dom.Document;

import item.model.ItemBean;
import item.model.ItemService;

@WebServlet("/item/search.controller")
public class SearchServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	private ItemService itemService;

	@Override
	public void init() throws ServletException {
		ServletContext application = this.getServletContext();
		ApplicationContext context = WebApplicationContextUtils.getWebApplicationContext(application);
		itemService = (ItemService) context.getBean("itemService");
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");

		// 接受資料
		String searchSelector = request.getParameter("searchSelector");
		String searchBar = request.getParameter("searchBar");
		String tempLat = request.getParameter("latitude");
		String tempLng = request.getParameter("longitude");
		String tempBounds = request.getParameter("bounds");

		System.out.println(searchSelector);
		System.out.println(searchBar);
		System.out.println(tempLat);
		System.out.println(tempLng);
		System.out.println("bounds = " + tempBounds);

		String temp_swLat = null;
		String temp_swLng = null;
		String temp_neLat = null;
		String temp_neLng = null;

		// 搜尋地區取得經緯度資訊
		if ("location".equals(searchSelector)) {
			int responseCode = 0;
			String api = "http://maps.googleapis.com/maps/api/geocode/xml?address="
					+ URLEncoder.encode(searchBar, "UTF-8") + "&sensor=true";
			System.out.println("URL : " + api);
			URL url = new URL(api);
			HttpURLConnection httpConnection = (HttpURLConnection) url.openConnection();
			httpConnection.connect();
			responseCode = httpConnection.getResponseCode();

			if (responseCode == 200) {
				try {
					DocumentBuilder builder = DocumentBuilderFactory.newInstance().newDocumentBuilder();
					Document document = builder.parse(httpConnection.getInputStream());
					XPathFactory xPathfactory = XPathFactory.newInstance();
					XPath xpath = xPathfactory.newXPath();
					XPathExpression expr = xpath.compile("/GeocodeResponse/status");
					String status = (String) expr.evaluate(document, XPathConstants.STRING);
					if (status.equals("OK")) {
						expr = xpath.compile("//geometry/location/lat");
						tempLat = (String) expr.evaluate(document, XPathConstants.STRING);
						expr = xpath.compile("//geometry/location/lng");
						tempLng = (String) expr.evaluate(document, XPathConstants.STRING);
						expr = xpath.compile("//geometry/viewport/southwest/lat");
						temp_swLat = (String) expr.evaluate(document, XPathConstants.STRING);
						expr = xpath.compile("//geometry/viewport/southwest/lng");
						temp_swLng = (String) expr.evaluate(document, XPathConstants.STRING);
						expr = xpath.compile("//geometry/viewport/northeast/lat");
						temp_neLat = (String) expr.evaluate(document, XPathConstants.STRING);
						expr = xpath.compile("//geometry/viewport/northeast/lng");
						temp_neLng = (String) expr.evaluate(document, XPathConstants.STRING);
						System.out.println("swLat=" + temp_swLat + "," + "swLng=" + temp_swLng + "," + "neLat="
								+ temp_neLat + "," + "neLng=" + temp_neLng);
					} else {
						throw new Exception("Error from the API - response status: " + status);
					}
				} catch (Exception e) {

				}
			}
		}

		// 搜尋物品帶入經緯度資訊
		if ("itemName".equals(searchSelector)) {
			if (tempBounds != null && tempBounds.length() != 0) {
				String[] arrayBounds = tempBounds.split(" ");
//				for (String aBounds : arrayBounds) {
//					System.out.println(aBounds);
//				}
				temp_swLat = arrayBounds[0].substring(2, arrayBounds[0].indexOf(","));
				temp_swLng = arrayBounds[1].substring(0, arrayBounds[1].indexOf(")"));
				temp_neLat = arrayBounds[2].substring(1, arrayBounds[2].indexOf(","));
				temp_neLng = arrayBounds[3].substring(0, arrayBounds[3].indexOf(")"));
				System.out.println("swLat = " + temp_swLat);
				System.out.println("swLng = " + temp_swLng);
				System.out.println("neLat = " + temp_neLat);
				System.out.println("neLng = " + temp_neLng);
			}
		}

		// 驗證資料

		// 轉換資料
		double lat = 0;
		if (tempLat != null && tempLat.length() != 0) {
			try {
				lat = Double.parseDouble(tempLat);
				request.setAttribute("currentLat", lat);
			} catch (NumberFormatException e) {
				e.printStackTrace();
			}
		}
		double lng = 0;
		if (tempLng != null && tempLng.length() != 0) {
			try {
				lng = Double.parseDouble(tempLng);
				request.setAttribute("currentLng", lng);
			} catch (NumberFormatException e) {
				e.printStackTrace();
			}
		}
		double swLat = 0;
		if (temp_swLat != null && temp_swLat.length() != 0) {
			try {
				swLat = Double.parseDouble(temp_swLat);
				request.setAttribute("swLat", swLat);
			} catch (NumberFormatException e) {
				e.printStackTrace();
			}
		}
		double swLng = 0;
		if (temp_swLng != null && temp_swLng.length() != 0) {
			try {
				swLng = Double.parseDouble(temp_swLng);
				request.setAttribute("swLng", swLng);
			} catch (NumberFormatException e) {
				e.printStackTrace();
			}
		}
		double neLat = 0;
		if (temp_neLat != null && temp_neLat.length() != 0) {
			try {
				neLat = Double.parseDouble(temp_neLat);
				request.setAttribute("neLat", neLat);
			} catch (NumberFormatException e) {
				e.printStackTrace();
			}
		}
		double neLng = 0;
		if (temp_neLng != null && temp_neLng.length() != 0) {
			try {
				neLng = Double.parseDouble(temp_neLng);
				request.setAttribute("neLng", neLng);
			} catch (NumberFormatException e) {
				e.printStackTrace();
			}
		}

		// 呼叫Model，根據Model的執行結果，顯示View (地區)
		if ("location".equals(searchSelector)) {
			List<ItemBean> result = itemService.selectByLatLng(swLat, swLng, neLat, neLng);
			request.setAttribute("itemBean", result);
			request.setAttribute("searchBar", searchBar);
			RequestDispatcher rd = request.getRequestDispatcher("/item/SearchLocation.jsp");
			rd.forward(request, response);
			return;
		}

		// 呼叫Model，根據Model的執行結果，顯示View (物品)
		if ("itemName".equals(searchSelector)) {
			ItemBean itemBean = new ItemBean();
			itemBean.setItem_name(searchBar);
			request.setAttribute("searchBar", searchBar);
			List<ItemBean> result = itemService.selectByBoundsByName(swLat, swLng, neLat, neLng, searchBar);
//			List<ItemBean> result = itemService.selectByName(itemBean);
			request.setAttribute("itemBean", result);
			RequestDispatcher rd = request.getRequestDispatcher("/item/SearchItemName.jsp");
			rd.forward(request, response);
			return;
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}
