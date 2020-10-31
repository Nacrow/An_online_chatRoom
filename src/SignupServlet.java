import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;

@WebServlet(name = "SignupServlet")
public class SignupServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String DBDRIVER="com.mysql.jdbc.Driver";
        //数据库连接地址
        String DBURL="jdbc:mysql://localhost:3306/project";//example表示数据库
        String DBUSER="root";
        String DBPASS="990723";
        Connection conn =null;
        PreparedStatement pstmt=null;//定义数据库操作对象
        PreparedStatement pstmt2=null;//定义数据库操作对象
        PreparedStatement pstmt3=null;//定义数据库操作对象
        boolean flag=false;
        String in=null;
        PrintWriter out = response.getWriter();
        String name=request.getParameter("userName");
        String password=request.getParameter("setPassword");
        String picture=request.getParameter("radio");
        HttpSession session = request.getSession();
        try {
            Class.forName(DBDRIVER);
            conn= DriverManager.getConnection(DBURL,DBUSER,DBPASS);
            String sql="select name from user where name=?";
            pstmt=conn.prepareStatement(sql);//实例化操作
            pstmt.setString(1,name);
            ResultSet rSet=pstmt.executeQuery();
            if(rSet.next()){
                out.write("Fail to sign up. Name is exist.");
            }else {
                session.setAttribute("username", name);
                pstmt2=conn.prepareStatement("INSERT INTO `project`.`user` (`name`, `password`,`picture`) VALUES (?, ?,?);");
                pstmt2.setString(1,name);
                pstmt2.setString(2,password);
                pstmt2.setString(3,picture);
                pstmt2.executeUpdate();
                Class.forName("com.mysql.jdbc.Driver");
                Statement stm = DriverManager.getConnection("jdbc:mysql://localhost:3306/project", "root", "990723").createStatement();
                stm.executeUpdate("CREATE TABLE `project`.`"+name+"`(`idName` INT NOT NULL AUTO_INCREMENT, `GroupName` VARCHAR(45) NULL, PRIMARY KEY (`idName`));\n");
                //pstmt3=conn.prepareStatement("CREATE TABLE `project`.? (`idName` INT NOT NULL AUTO_INCREMENT, `GroupName` VARCHAR(45) NULL,\n + PRIMARY KEY (`idName`));\n");
                //pstmt3.executeUpdate();
                response.sendRedirect("index.jsp");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
