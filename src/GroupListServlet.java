import org.json.JSONObject;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.sql.*;

@WebServlet(name = "GroupListServlet")
public class GroupListServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json;charset=utf-8");
        String user= request.getParameter("username");
        try
        {
            Class.forName("com.mysql.jdbc.Driver");
            Statement conn=DriverManager.getConnection("jdbc:mysql://localhost:3306/project","root","990723").createStatement();
            String header_sql = "SELECT * FROM "+user;
            ResultSet header_rs = conn.executeQuery(header_sql);
            ArrayList<JSONObject> array1 = new ArrayList<JSONObject>();
            while(header_rs.next()) {
                JSONObject bean1 = new JSONObject();
                bean1.put("GroupName", header_rs.getString(2));
                array1.add(bean1);
            }
            PrintWriter pw1 = response.getWriter();
            pw1.print(array1);
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
}
