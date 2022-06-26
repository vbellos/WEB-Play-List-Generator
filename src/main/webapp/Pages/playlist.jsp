<%@ page import="com.example.demo.Models.Playlist" %>
<%@ page import="Api.SpotifyAuth" %>
<%@ page import="se.michaelthelin.spotify.SpotifyApi" %>
<%@ page import="java.io.IOException" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="se.michaelthelin.spotify.requests.data.tracks.GetTrackRequest" %>
<%@ page import="se.michaelthelin.spotify.model_objects.specification.Track" %>
<%@ page import="se.michaelthelin.spotify.exceptions.SpotifyWebApiException" %>
<%@ page import="org.apache.hc.core5.http.ParseException" %>
<%@ page import="se.michaelthelin.spotify.model_objects.specification.TrackSimplified" %>
<%@ page import="se.michaelthelin.spotify.requests.data.browse.GetRecommendationsRequest" %>
<%@ page import="Api.SpotifyPlaylistLoader" %>
<%@ page import="se.michaelthelin.spotify.model_objects.specification.Artist" %>
<%@ page import="se.michaelthelin.spotify.model_objects.specification.ArtistSimplified" %>
<%@ page import="Api.LyricsLoader" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%Playlist playlist = (Playlist) request.getAttribute("playlist"); %>
<%ArrayList<Track> tracks = new ArrayList<Track>();%>
<%ArrayList<TrackSimplified> recomendations = new ArrayList<>();%>
<%
    LyricsLoader lyricsLoader = new LyricsLoader(); %>
<%
    SpotifyPlaylistLoader spotifyPlaylistLoader = new SpotifyPlaylistLoader(playlist);
    spotifyPlaylistLoader.setSpotifyAuthLoadedListener(new SpotifyPlaylistLoader.SpotifyAuthLoaded() {
        @Override
        public void onAuthLoaded() throws IOException {
            tracks.addAll(spotifyPlaylistLoader.getTracks());
            recomendations.addAll(spotifyPlaylistLoader.getRecomendations());
        }
    });
%>


<html>
<head>
    <%@include file="/WEB-INF/styles.jsp"%>

    <title>Title</title>
    <%@ include file="navbar.jsp" %>

</head>
<body>

<br>
<div class="row p-3">

    <div class="col-sm-6">
        <div class="container trackview bg-dark">

            <table class="table table-hover table-dark">
                <thead>
                <tr>
                    <th><%=playlist.getPlaylist_name()%></th>

                </tr>
                </thead>
                <tbody>
                    <%for(Track t : tracks){ %>
                    <%ArtistSimplified artist = t.getArtists()[0];%>
                    <tr>
                        <td><iframe loading="lazy" src="https://open.spotify.com/embed/track/<%=t.getId()%>" width="300" height="80" frameborder="0" data-mce-fragment="1"></iframe></td>
                        <td>
                            <a class="btn btn-outline-success" data-toggle="collapse" href="#lyrics_<%=t.getId()%>" role="button" aria-expanded="false" aria-controls="lyrics_<%=t.getId()%>">
                                Lyrics <i class="bi bi-caret-down"></i>

                            </a>
                        </td>
                        <td><a href="Playlist?playlist_id=<%=playlist.getPlaylist_id()%>&action=delete&track_id=<%=t.getId()%>" class="btn btn-outline-danger"><i class="bi bi-trash3"></i>
                        </a></td>

                    </tr>
                    <tr>
                        <td colspan="6" class="hiddenRow"><div id="lyrics_<%=t.getId()%>" class="accordian-body collapse">
                            <%=lyricsLoader.GetLyrics(t.getName().toString(),artist.getName()).toString()%>
                        </div></td>
                    </tr>


                <%}%>
                </tbody>
            </table>
        </div>
    </div>

    <div class="col-sm-6">
        <div class="container trackview bg-dark">
            <table class="table table-hover table-dark">
                <thead>
                <tr>
                    <th>Recommendations</th>
                </tr>
                </thead>
                <tbody>
                <%for(TrackSimplified ts : recomendations){%>
                <tr>
                    <td><iframe loading="lazy" src="https://open.spotify.com/embed/track/<%=ts.getId()%>" width="300" height="80" frameborder="0" data-mce-fragment="1"></iframe></td>
                    <td><a class="btn btn-outline-success" data-toggle="collapse" href="#rec_lyrics_<%=ts.getId()%>" role="button" aria-expanded="false" aria-controls="rec_lyrics_<%=ts.getId()%>">
                        Lyrics <i class="bi bi-caret-down"></i>
                    </a></td>
                    <td><a href="Playlist?playlist_id=<%=playlist.getPlaylist_id()%>&action=add&track_id=<%=ts.getId()%>" class="btn btn-outline-success"><i class="bi bi-plus"></i>
                    </a></td>

                </tr>
                <td colspan="6" class="hiddenRow"><div id="rec_lyrics_<%=ts.getId()%>" class="accordian-body collapse">
                    <%=lyricsLoader.GetLyrics(ts.getName().toString(),ts.getArtists()[0].getName().toString())%>
                </div></td>
                </tr>

                <%}%>
                </tbody>
            </table>

        </div>
    </div>

</div>



</body>
</html>
