package Pages;

import com.example.demo.Dao.Dao;
import com.example.demo.Models.Playlist;
import com.example.demo.Models.User;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet(name = "HomeServlet", value = "/")

public class HomeServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request,response);


    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        RequestDispatcher dispatcher =request.getRequestDispatcher("/Pages/home.jsp");

        String delete_playlist =request.getParameter("delete_playlist");
        User user = (User) request.getSession().getAttribute("user");
        if(user!=null && delete_playlist!=null)
        {
            new Dao().removePlaylist(delete_playlist, user.getUser_id());
        }

        dispatcher.forward(request, response);
    }


}
