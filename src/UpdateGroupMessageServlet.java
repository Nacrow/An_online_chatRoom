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
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

@WebServlet(name = "UpdateGroupMessageServlet")
public class UpdateGroupMessageServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json;charset=utf-8");
        String GroupNo=request.getParameter("groupName");
        try
        {
            Class.forName("com.mysql.jdbc.Driver");
            Statement stm3 = DriverManager.getConnection("jdbc:mysql://localhost:3306/project", "root", "990723").createStatement();
            String sql3s = "SELECT * FROM groupmessage,user where user.name=groupmessage.Author and groupName = '"+ GroupNo+"' ORDER BY idGroupmessage";
            ResultSet sql3 = stm3.executeQuery(sql3s);
            ArrayList<JSONObject> array = new ArrayList<JSONObject>();
            while(sql3.next()) {
                JSONObject bean = new JSONObject();
                bean.put("content", sql3.getString("content"));
                bean.put("Date", sql3.getString("Date"));
                bean.put("Time", sql3.getString("Time"));
                bean.put("Author", sql3.getString("Author"));
                bean.put("Picture",sql3.getString("picture"));
                array.add(bean);
            }
            PrintWriter pw = response.getWriter();
            pw.print(array);
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
