import org.json.JSONObject;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

@WebServlet(name = "FriendListServlet")
public class FriendListServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json;charset=utf-8");
        String user= request.getParameter("username");
        try
        {
            Class.forName("com.mysql.jdbc.Driver");
            Statement stm2 = DriverManager.getConnection("jdbc:mysql://localhost:3306/project", "root", "990723").createStatement();
            String header_sql = "SELECT * FROM friendlist,user where Friend1= '"+ user+"' and Friend2=user.name";
                String header_sql2 = "SELECT * FROM friendlist,user where Friend2= '"+ user+"' and Friend1=user.name";
                ResultSet header_rs = stm2.executeQuery(header_sql);
                ArrayList<JSONObject> array1 = new ArrayList<JSONObject>();
                while(header_rs.next()) {
                    JSONObject bean1 = new JSONObject();
                    bean1.put("Friend", header_rs.getString("Friend2"));
                    bean1.put("Nu",header_rs.getInt("id"));
                    bean1.put("picture",header_rs.getString("picture"));
                    array1.add(bean1);
            }
            header_rs.close();
            ResultSet rs=stm2.executeQuery(header_sql2);
            while(rs.next()) {
                JSONObject bean1 = new JSONObject();
                bean1.put("Friend", rs.getString("Friend1"));
                bean1.put("Nu",rs.getInt("id"));
                bean1.put("picture",rs.getString("picture"));
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
