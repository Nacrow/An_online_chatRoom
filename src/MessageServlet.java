import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.DriverManager;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.Date;

@WebServlet(name = "MessageServlet")
public class MessageServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json;charset=utf-8");
        java.util.Date d = new Date();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        String cd = sdf.format(d);
        SimpleDateFormat time = new SimpleDateFormat("hh:mm:ss");
        String ee = time.format(d);
        //HttpSession session = request.getSession();
        //   int st = (int)session.getAttribute("status");
        String context= request.getParameter("content");
        String number= request.getParameter("No");
        String author= request.getParameter("Author");
        try
        {
            Class.forName("com.mysql.jdbc.Driver");
            Statement stm = DriverManager.getConnection("jdbc:mysql://localhost:3306/project", "root", "990723").createStatement();
            String sql = "INSERT INTO `project`.`message` (`Content`, `Date`,`time`,`Author`,`roomNo`) VALUES ('"+context+"','"+cd+"','"+ee+"','"+author+"','"+number+"');";
            stm.execute(sql);
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
