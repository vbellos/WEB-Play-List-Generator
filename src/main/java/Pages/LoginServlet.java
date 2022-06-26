package Pages;
import com.example.demo.Dao.Dao;
import com.example.demo.Models.User;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;

/**
 * Servlet implementation class LoginServlet
 */
@WebServlet("/Login")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private Dao loginDao;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public void init() {
        loginDao = new Dao();
    }


    /**
     * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // TODO Auto-generated method stub
        response.getWriter().append("Served at: ").append(request.getContextPath());
        RequestDispatcher dispatcher =request.getRequestDispatcher("/Pages/login.jsp");
        dispatcher.forward(request, response);

    }

    /**
     * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // TODO Auto-generated method stub
        String email = request.getParameter("email");
        String password = request.getParameter("password");


        try {
            User user = loginDao.login(email,password);

            if(user != null) {
                    HttpSession session = request.getSession();
                    session.setMaxInactiveInterval(10*60);
                    session.setAttribute("user", user);
                    request.getRequestDispatcher("/").forward(request, response);

            } else {
                HttpSession session = request.getSession();
                RequestDispatcher dispatcher =request.getRequestDispatcher("/Pages/login.jsp");
                dispatcher.forward(request, response);
            }
        } catch ( SQLException e) {
            e.printStackTrace();
        }
    }

}
