package Pages;



import com.example.demo.Dao.Dao;
import com.example.demo.Models.User;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "AccountServlet", value = "/Account")
public class AccountServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        Dao userDao = new Dao();
        String action = request.getParameter("action");
        User user = (User) request.getSession().getAttribute("user");
        if (user == null){response.sendRedirect("./Login");}
        else {
            if(action!= null && action.equals("upgrade"))
            {userDao.UpgradeUser(user.getUser_id());
                user.setType("premium");
                request.getSession().setAttribute("user",user);
            }
            response.getWriter().append("Served at: ").append(request.getContextPath());
            RequestDispatcher dispatcher = request.getRequestDispatcher("/Pages/account.jsp");
            dispatcher.forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");
        String name = request.getParameter("name");
        String password = request.getParameter("password");
        String email = request.getParameter("email");


        Dao userDao = new Dao();
        if(user != null)
        {


                user.setName(name);
                user.setEmail(email);
                user.setPassword(password);
                userDao.UpdateUser(user);
                request.getSession().setAttribute("user",user);

            response.sendRedirect("./Account");
        }else {
            response.sendRedirect("./Login");
        }
    }
}
