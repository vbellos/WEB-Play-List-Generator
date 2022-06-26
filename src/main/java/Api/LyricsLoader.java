package Api;


import org.jmusixmatch.MusixMatch;
import org.jmusixmatch.MusixMatchException;
import org.jmusixmatch.entity.lyrics.Lyrics;
import org.jmusixmatch.entity.track.Track;
import org.jmusixmatch.entity.track.TrackData;

public class LyricsLoader {

    String apiKey = "f8e43650c484ceb54d6a50fe81b0218c";
    MusixMatch musixMatch = new MusixMatch(apiKey);

    public String GetLyrics(String title,String artist)  {
        if(title==null || artist==null){return "";}
        Track track = null;
        try {
            track = musixMatch.getMatchingTrack(title, artist);
        } catch (MusixMatchException e) {
            return "";
        }
        TrackData data = track.getTrack();
        int trackID = data.getTrackId();

        Lyrics lyrics = null;
        try {
            lyrics = musixMatch.getLyrics(trackID);
        } catch (MusixMatchException e) {
           return "";
        }
        return lyrics.getLyricsBody().toString();
    }
}
