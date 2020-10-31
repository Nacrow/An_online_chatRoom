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

@WebServlet(name = "ChatRoomUpdateServlet")
public class ChatRoomUpdateServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
            response.setContentType("application/json;charset=utf-8");
        try
        {
            Class.forName("com.mysql.jdbc.Driver");
        Statement stm2 = DriverManager.getConnection("jdbc:mysql://localhost:3306/project", "root", "990723").createStatement();
        String header_sql = "SELECT * FROM roomlist";
        ResultSet header_rs = stm2.executeQuery(header_sql);
        ArrayList<JSONObject> array1 = new ArrayList<JSONObject>();
        while(header_rs.next()) {
            JSONObject bean1 = new JSONObject();
            bean1.put("RoomName", header_rs.getString(1));
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
