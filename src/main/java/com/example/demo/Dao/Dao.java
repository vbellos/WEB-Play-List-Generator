package com.example.demo.Dao;


import com.example.demo.Models.Playlist;
import com.example.demo.Models.User;
import com.example.demo.Util.DbUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class Dao {

    Connection connection = DbUtil.getConnection();

    public User login(String email, String password) throws SQLException {


        PreparedStatement preparedStatement = connection.prepareStatement("select * from users where email = ? and password = ? ");
        {
            preparedStatement.setString(1, email);

            preparedStatement.setString(2, password);

            System.out.println(preparedStatement);
            ResultSet rs = preparedStatement.executeQuery();

            if (rs.next()) {
                User user = new User();
                user.setUser_id(rs.getString("user_id"));
                user.setName(rs.getString("name"));
                user.setType(rs.getString("type"));
                user.setPassword(rs.getString("password"));
                user.setEmail(rs.getString("email"));
                return user;
            }

            return null;
        }

    }

    public int RegisterUser(User user) {
        int result = 0;

        //Create a statement using connection object
        PreparedStatement preparedStatement;
        try {

            user.setUser_id(java.util.UUID.randomUUID().toString());


            preparedStatement = connection.prepareStatement("INSERT INTO users ( user_id, name, email, password, type) VALUES (?, ?, ?, ?, ?);");
            preparedStatement.setString(1, user.getUser_id());
            preparedStatement.setString(2, user.getName());
            preparedStatement.setString(3, user.getEmail());
            preparedStatement.setString(4,user.getPassword());
            preparedStatement.setString(5,"free");

            System.out.println(preparedStatement);
            //Execute the query or update query
            result = preparedStatement.executeUpdate();
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }

        return result;
    }
    public void UpdateUser (User user)
    {
        try {
            PreparedStatement preparedStatement = connection
                    .prepareStatement("update users set name  =? , password =?, email =? where user_id=?");
            // Parameters start with 1
            preparedStatement.setString(1,user.getName());
            preparedStatement.setString(2, user.getPassword());
            preparedStatement.setString(3, user.getEmail());
            preparedStatement.setString(4, user.getUser_id());
            preparedStatement.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void UpgradeUser(String user_id) {
        try {
            PreparedStatement preparedStatement = connection
                    .prepareStatement("update users set type  =? where user_id=?");
            // Parameters start with 1
            preparedStatement.setString(1,"premium");
            preparedStatement.setString(2,user_id);
            preparedStatement.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public boolean isUserPremium(String user_id) throws SQLException {
        PreparedStatement preparedStatement = connection.prepareStatement("select type from users where user_id = ? ");
        {
            preparedStatement.setString(1, user_id);

            ResultSet rs = preparedStatement.executeQuery();

            if (rs.next()) {
                String type = rs.getString("type");
                if(type.equals("premium")){return true;}
                    else{return false;}
            }

            return false;
        }
    }

    public void addPlaylistGenre(String playlist_id,String genre)
    {
        PreparedStatement preparedStatement;
        try {

            preparedStatement = connection.prepareStatement("INSERT INTO playlist_genres ( playlist_id , genre) VALUES (?, ?);");
            preparedStatement.setString(1, playlist_id);
            preparedStatement.setString(2, genre);

            System.out.println(preparedStatement);
            //Execute the query or update query
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }

    public int CreatePlaylist(Playlist playlist) throws SQLException {
        int result = 0;
        int user_playlist_count =GetUserPlaylistCount(playlist.getUser_id());
        boolean isCountOk = user_playlist_count >-1 && user_playlist_count <=3;
        if(isCountOk || isUserPremium(playlist.getUser_id())) {
            //Create a statement using connection object
            PreparedStatement preparedStatement;
            try {



                preparedStatement = connection.prepareStatement("INSERT INTO playlists ( playlist_id,user_id, playlist_name) VALUES (?, ?, ?);");
                preparedStatement.setString(1, playlist.getPlaylist_id());
                preparedStatement.setString(2, playlist.getUser_id());
                preparedStatement.setString(3, playlist.getPlaylist_name());
                System.out.println(preparedStatement);
                //Execute the query or update query
                result = preparedStatement.executeUpdate();

                if (result != 0) {
                    for (String g : playlist.getGenres()) {
                        addPlaylistGenre(playlist.getPlaylist_id(), g);
                    }
                }

            } catch (SQLException e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }

        }
        return result;
    }

    public void addPlaylistTrack(String playlist_id ,String track_id)
    {
        PreparedStatement preparedStatement;
        try {

            preparedStatement = connection.prepareStatement("INSERT INTO playlist_tracks ( playlist_id,track_id) VALUES (?, ?);");
            preparedStatement.setString(1, playlist_id);
            preparedStatement.setString(2, track_id);

            System.out.println(preparedStatement);
            //Execute the query or update query
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }

    public void removePlaylistTrack(String playlist_id ,String track_id)
    {
        PreparedStatement preparedStatement;
        try {

            preparedStatement = connection.prepareStatement("DELETE FROM playlist_tracks  where playlist_id = ? and track_id = ?;");
            preparedStatement.setString(1, playlist_id);
            preparedStatement.setString(2, track_id);

            System.out.println(preparedStatement);
            //Execute the query or update query
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }

    public void removePlaylist(String playlist_id ,String user_id)
    {
        PreparedStatement preparedStatement;
        try {

            preparedStatement = connection.prepareStatement("DELETE FROM playlists  where playlist_id = ? and user_id = ?;");
            preparedStatement.setString(1, playlist_id);
            preparedStatement.setString(2, user_id);

            System.out.println(preparedStatement);
            //Execute the query or update query
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }

    public int GetUserPlaylistCount(String user_id) throws SQLException {
        int count = 0;

        PreparedStatement preparedStatement = connection.prepareStatement("select playlist_id from playlists where user_id = ? ");
        {
            preparedStatement.setString(1, user_id);

            ResultSet rs = preparedStatement.executeQuery();
            while (rs.next())
            {
               count++;
            }
        }
        return count;
    }

    public Playlist GetPlaylist(String playlist_id) throws SQLException {
        PreparedStatement preparedStatement = connection.prepareStatement("select * from playlists where playlist_id = ? ");
        {
            preparedStatement.setString(1, playlist_id);

            ResultSet rs = preparedStatement.executeQuery();
            if (rs.next())
            {
                Playlist playlist = new Playlist();
                playlist.setPlaylist_id(playlist_id);
                playlist.setPlaylist_name(rs.getString("playlist_name"));
                playlist.setUser_id(rs.getString("user_id"));
                playlist.setTracks(GetPlaylistTracks(playlist_id));
                playlist.setGenres(GetPlaylistGenres(playlist_id));
                return playlist;
            }
            return null;
        }
    }



    public List<Playlist> GetUserPlaylists(String user_id) throws SQLException {
        List<Playlist> playlists = new ArrayList<>();
        PreparedStatement preparedStatement = connection.prepareStatement("select * from playlists where user_id = ? ");
        {
            preparedStatement.setString(1, user_id);

            ResultSet rs = preparedStatement.executeQuery();
            while (rs.next())
            {
                Playlist playlist = new Playlist();
                playlist.setPlaylist_id(rs.getString("playlist_id"));
                playlist.setPlaylist_name(rs.getString("playlist_name"));
                playlist.setUser_id(rs.getString("user_id"));
                playlists.add(playlist);
            }

        }
        return playlists;
    }

    public ArrayList<String> GetPlaylistTracks(String playlist_id) throws SQLException {
        ArrayList<String> tracks = new ArrayList<>();

        PreparedStatement preparedStatement = connection.prepareStatement("select * from playlist_tracks where playlist_id = ? ");
        {
            preparedStatement.setString(1, playlist_id);

            ResultSet rs = preparedStatement.executeQuery();
            while (rs.next())
            {
                String track = rs.getString("track_id");
                tracks.add(track);
            }

        }

        return tracks;
    }

    public ArrayList<String> GetPlaylistGenres(String playlist_id) throws SQLException {
        ArrayList<String> genres = new ArrayList<>();

        PreparedStatement preparedStatement = connection.prepareStatement("select * from playlist_genres where playlist_id = ? ");
        {
            preparedStatement.setString(1, playlist_id);

            ResultSet rs = preparedStatement.executeQuery();
            while (rs.next())
            {
                String genre = rs.getString("genre");
                genres.add(genre);
            }

        }

        return genres;
    }

}
