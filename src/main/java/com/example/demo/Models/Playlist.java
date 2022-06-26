package com.example.demo.Models;

import java.util.ArrayList;

public class Playlist {
    private String user_id,playlist_id,playlist_name;
    private ArrayList<String> tracks = new ArrayList<>() , genres = new ArrayList<>();

    public String getUser_id() {
        return user_id;
    }

    public void setUser_id(String user_id) {
        this.user_id = user_id;
    }

    public String getPlaylist_id() {
        return playlist_id;
    }

    public void setPlaylist_id(String playlist_id) {
        this.playlist_id = playlist_id;
    }

    public String getPlaylist_name() {
        return playlist_name;
    }

    public void setPlaylist_name(String playlist_name) {
        this.playlist_name = playlist_name;
    }

    public ArrayList<String> getTracks() {
        return tracks;
    }

    public void setTracks(ArrayList<String> tracks) {
        this.tracks = tracks;
    }

    public ArrayList<String> getGenres() {
        return genres;
    }

    public void setGenres(ArrayList<String> genres) {
        this.genres = genres;
    }

    public void addTrack(String track_id)
    {
        tracks.add(track_id);
    }
    public void removeTrack(String track_id)
    {
        if(tracks.contains(track_id)){tracks.remove(track_id);}
    }


}
