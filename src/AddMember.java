import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.DriverManager;
import java.sql.Statement;

@WebServlet(name = "AddMember")
public class AddMember extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json;charset=utf-8");
        //HttpSession session = request.getSession();
        //   int st = (int)session.getAttribute("status");
        String Name= request.getParameter("newMember");
        String Group=request.getParameter("Group");
        try
        {
            Class.forName("com.mysql.jdbc.Driver");
            Statement stm = DriverManager.getConnection("jdbc:mysql://localhost:3306/project", "root", "990723").createStatement();
            stm.executeUpdate("INSERT INTO "+Name+" (`GroupName`) VALUES ('"+Group+"')");
            stm.executeUpdate("INSERT INTO grouplist (`Name`,`Allow`) VALUES ('"+Name+"','"+Group+"')");
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
