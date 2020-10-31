import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;



public class LoginServlet extends HttpServlet {
		protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
			String DBDRIVER="com.mysql.jdbc.Driver";
			//数据库连接地址
			String DBURL="jdbc:mysql://localhost:3306/project";//example表示数据库
			String DBUSER="root";
			String DBPASS="990723";
			Connection conn =null;
			PreparedStatement pstmt=null;//定义数据库操作对象
			boolean flag=false;
			String in=null;
			PrintWriter out = response.getWriter();
			String name=request.getParameter("name");
			String password=request.getParameter("password");
			HttpSession session = request.getSession();
			try {
				Class.forName(DBDRIVER);
				conn= DriverManager.getConnection(DBURL,DBUSER,DBPASS);
				String sql="select name from user where name=? and password=?";
				pstmt=conn.prepareStatement(sql);//实例化操作
				pstmt.setString(1,name);
				pstmt.setString(2,password);
				ResultSet rSet=pstmt.executeQuery();
				if(rSet.next()){
					session.setAttribute("username", name);
					response.sendRedirect("index.jsp");
				}else {
					out.write("Login fail.Wrong password or name.");
				}						
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
			doGet(request, response);
		}

}
