import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

@WebServlet(name = "newFriendServlet")
public class newFriendServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json;charset=utf-8");
        String Name= request.getParameter("Name");
        String Author= request.getParameter("Author");
        try
        {
            Class.forName("com.mysql.jdbc.Driver");
            Statement stm = DriverManager.getConnection("jdbc:mysql://localhost:3306/project", "root", "990723").createStatement();
            ResultSet w=stm.executeQuery("SELECT * FROM friendlist where (Friend1='"+Name+"'AND Friend2='"+Author+"') OR (Friend2='"+Name+"'AND Friend1='"+Author+"')");
            if (w.next())
            {

            }
            else
            {
                stm.executeUpdate("INSERT INTO friendlist (`Friend1`,  `Friend2`) VALUES ('"+Name+"','"+Author+"')");
            }

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
