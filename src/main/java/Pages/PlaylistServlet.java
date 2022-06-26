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

@WebServlet(name = "PlaylistServlet", value = "/Playlist")
public class PlaylistServlet extends HttpServlet {



    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request,response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html; charset=UTF-8");
        response.setCharacterEncoding("UTF-8");
        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");

        if(action==null){action = "";}
        String track_id = request.getParameter("track_id");
        if(track_id == null){track_id = "";}
        Dao dao = new Dao();

        User user =(User) request.getSession().getAttribute("user");
        String playlist_id = request.getParameter("playlist_id");
        if (user!= null && playlist_id!=null)
        {   Playlist playlist = new Playlist();
            try {
                playlist = dao.GetPlaylist(playlist_id);
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }

            if (action.equalsIgnoreCase("add")){
                playlist.addTrack(track_id);
                dao.addPlaylistTrack(playlist.getPlaylist_id(),track_id);
            } else if (action.equalsIgnoreCase("delete")){
               playlist.removeTrack(track_id);
               dao.removePlaylistTrack(playlist.getPlaylist_id(),track_id);
            }
            RequestDispatcher view = request.getRequestDispatcher("/Pages/playlist.jsp");
            request.setAttribute("playlist",playlist);
            view.forward(request,response);

        }
        else
        {
            RequestDispatcher view = request.getRequestDispatcher("/");
            view.forward(request, response);
        }




    }
}
