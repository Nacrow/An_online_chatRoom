import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import org.json.JSONException;
import org.json.JSONObject;


@WebServlet(name = "UpdateServlet")
public class UpdateServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json;charset=utf-8");
        int chatRoomNo=Integer.parseInt(request.getParameter("RoomNo"));
        try
        {
            Class.forName("com.mysql.jdbc.Driver");
            Statement stm3 = DriverManager.getConnection("jdbc:mysql://localhost:3306/project", "root", "990723").createStatement();
            String sql3s = "SELECT * FROM message,user where message.Author=user.name and roomNo="+chatRoomNo+" ORDER BY idMessage";
            ResultSet sql3 = stm3.executeQuery(sql3s);
            ArrayList<JSONObject> array = new ArrayList<JSONObject>();
            while(sql3.next()) {
                JSONObject bean = new JSONObject();
                bean.put("content", sql3.getString("Content"));
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

                //div.innerHTML +=<%=sql3.getString(5)%> +"("+ date +"&nbsp;"+time+ ")"+":<br/>&nbsp;&nbsp;&nbsp;" + "<%=sql3.getString(2)%> "+ '<br/><br/>';
                //div.scrollTop = div.scrollHeight;

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
}
