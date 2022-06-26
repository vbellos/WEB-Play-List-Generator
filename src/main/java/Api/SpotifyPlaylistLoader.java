package Api;

import com.example.demo.Models.Playlist;
import se.michaelthelin.spotify.SpotifyApi;
import se.michaelthelin.spotify.exceptions.SpotifyWebApiException;
import se.michaelthelin.spotify.model_objects.specification.Track;
import se.michaelthelin.spotify.model_objects.specification.TrackSimplified;
import se.michaelthelin.spotify.requests.data.browse.GetRecommendationsRequest;
import se.michaelthelin.spotify.requests.data.tracks.GetTrackRequest;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

public class SpotifyPlaylistLoader {
    private SpotifyAuth spotifyAuth = new SpotifyAuth();


    private Playlist _playlist;
    SpotifyApi _spotifyApi;
    public SpotifyPlaylistLoader(Playlist playlist)
    {
        _playlist = playlist;

    }
    public ArrayList<Track> getTracks()
    {
        ArrayList<Track> tracks = new ArrayList<>();

        if(_spotifyApi!=null)
        {
            for (String t : _playlist.getTracks()) {
                GetTrackRequest getTrackRequest =  _spotifyApi.getTrack(t).build();
                try {
                    Track track = getTrackRequest.execute();
                    tracks.add(track);
                } catch (SpotifyWebApiException | RuntimeException  e) {
                    throw new RuntimeException(e);
                } catch (IOException e) {
                    throw new RuntimeException(e);
                } catch (org.apache.hc.core5.http.ParseException e) {
                    throw new RuntimeException(e);
                }
            }

        }

        return tracks;
    }
    public ArrayList<TrackSimplified> getRecomendations()
    {
        ArrayList<TrackSimplified> recomendations = new ArrayList<>();

        ArrayList<String> genres = _playlist.getGenres();
        ArrayList<String> tracks = _playlist.getTracks();

        if(genres.size() + tracks.size() <= 5){recomendations.addAll(RecomendationsRequest(getGenreSeed(genres), getTrackSeed(tracks), 20));}
        else if (genres.size()>= 2) {
            for (int i=1; i<=4; i++)
            {
                ArrayList<String> sub_genres = new ArrayList<>();
                sub_genres.addAll(pickNRandom(genres, 2));
                ArrayList<String> sub_tracks = new ArrayList<>();
                sub_tracks.addAll(pickNRandom(tracks, 3));
                recomendations.addAll(RecomendationsRequest(getGenreSeed(sub_genres), getTrackSeed(sub_tracks), 5));
            }
        }
        else
        {
            for (int i=1; i<=4; i++)
            {
                ArrayList<String> sub_genres = new ArrayList<>();
                sub_genres.addAll(pickNRandom(genres, genres.size()));
                ArrayList<String> sub_tracks = new ArrayList<>();
                sub_tracks.addAll(pickNRandom(tracks, 5- genres.size()));
                recomendations.addAll(RecomendationsRequest(getGenreSeed(sub_genres), getTrackSeed(sub_tracks), 5));
            }

        }

        return recomendations;
    }
    public static List<String> pickNRandom(ArrayList<String> lst, int n) {
        ArrayList<String> copy = new ArrayList<String>(lst);
        Collections.shuffle(copy);
        return n > copy.size() ? copy.subList(0, copy.size()) : copy.subList(0, n);
    }
    public ArrayList<TrackSimplified> RecomendationsRequest(String seed_genres ,String seed_tracks , int limit)
    {    ArrayList<TrackSimplified> recomendations = new ArrayList<>();
        if(_spotifyApi!=null)
        {
            System.out.println("track seed: " + seed_tracks);
            System.out.println("genre seed: " + seed_genres);

            GetRecommendationsRequest getRecommendationsRequest;
            if(seed_tracks==null || seed_tracks.equals(""))
            {getRecommendationsRequest= _spotifyApi.getRecommendations().seed_genres(seed_genres).limit(limit).build();}
            else{getRecommendationsRequest =_spotifyApi.getRecommendations().seed_tracks(seed_tracks).seed_genres(seed_genres).limit(limit).build(); }
            try {

                TrackSimplified rec[] = getRecommendationsRequest.execute().getTracks();
                for (TrackSimplified t: rec) {
                    recomendations.add(t);
                }
            } catch (SpotifyWebApiException | IOException |org.apache.hc.core5.http.ParseException e) {
                System.out.println(e.toString());
            }
        }

        return recomendations;
    }

    public interface SpotifyAuthLoaded
    {
        void onAuthLoaded() throws IOException;

    }
    SpotifyAuthLoaded spotifyLoadedListener = null;

    public void setSpotifyAuthLoadedListener(SpotifyAuthLoaded listener)
    {
        this.spotifyLoadedListener = listener;

        spotifyAuth.setSpotifyAuthListener(new SpotifyAuth.SpotifyAuthListener() {
            @Override
            public void onAuthSucceed(SpotifyApi spotifyApi) throws IOException {
                _spotifyApi = spotifyApi;
                listener.onAuthLoaded();
            }

            @Override
            public void onAuthFailed() {

            }
        });

    }

    public String getGenreSeed(ArrayList<String> genres)
    {
        String seed = "";
        int c= 0;
        for(String g : genres)
        {
            if(!g.equals(""))
            {
                if(c==0){seed = g;}else{seed = seed+","+g;}
            }
            c++;
        }
        return seed;
    }
    public  String getTrackSeed(ArrayList<String> tracks)
    {
        String seed = "";
        int c= 0;
        for(String g : tracks)
        {
            if(!g.equals(""))
            {
                if(c==0){seed = g;}else{seed = seed+","+g;}
            }
            c++;
        }
        return seed;
    }

}
