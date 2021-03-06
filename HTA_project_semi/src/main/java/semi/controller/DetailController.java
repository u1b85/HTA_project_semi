package semi.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import semi.dao.BooksDao;
import semi.vo.BooksVo;

@WebServlet("/detail")
public class DetailController extends HttpServlet{
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setAttribute("header1", "/header.jsp");
		req.setAttribute("body", "/category/detail.jsp");
		req.setAttribute("footer", "/footer.jsp");
		String id_item=req.getParameter("id_item");
		BooksDao dao=BooksDao.getInstance();
		BooksVo vo=dao.detail(id_item);
		req.setAttribute("vo", vo);
		req.getRequestDispatcher("/index.jsp").forward(req, resp);
	}
}