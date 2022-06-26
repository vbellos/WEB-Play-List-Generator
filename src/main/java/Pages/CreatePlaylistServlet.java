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
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;

@WebServlet("/CreatePlaylist")
public class CreatePlaylistServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // TODO Auto-generated method stub
        User user = (User) request.getSession().getAttribute("user");
        String playlist_name = request.getParameter("playlist_name");
       String[] genresList = request.getParameterValues("genres");
        ArrayList<String> genres = new ArrayList<>();
        if(genresList!=null){for(String g: genresList){genres.add(g);}}




            if(user != null) {
                Dao dao = new Dao();

                Playlist playlist = new Playlist();
                playlist.setPlaylist_id(java.util.UUID.randomUUID().toString());
                playlist.setUser_id(user.getUser_id());
                playlist.setPlaylist_name(playlist_name);
                playlist.setGenres(genres);
                try {
                    dao.CreatePlaylist(playlist);
                } catch (SQLException e) {
                    throw new RuntimeException(e);
                }
            }
        request.getRequestDispatcher("/").forward(request, response);


    }

}
