<%@ page import="com.example.demo.Models.User" %>
<%@ page import="com.example.demo.Models.Playlist" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="Api.SpotifyAuth" %>
<%@ page import="se.michaelthelin.spotify.SpotifyApi" %>
<%@ page import="java.io.IOException" %>
<%@ page import="se.michaelthelin.spotify.requests.data.browse.miscellaneous.GetAvailableGenreSeedsRequest" %>
<%@ page import="se.michaelthelin.spotify.exceptions.SpotifyWebApiException" %>
<%@ page import="java.text.ParseException" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<% User user = (User) session.getAttribute("user");
if(user==null){
    RequestDispatcher dispatcher = request.getRequestDispatcher("/Login");
    dispatcher.forward(request,response);
}
%>


<% ArrayList<String> genres = new ArrayList<>();%>
<% SpotifyAuth spotifyAuth = new SpotifyAuth();
    spotifyAuth.setSpotifyAuthListener(new SpotifyAuth.SpotifyAuthListener() {
        @Override
        public void onAuthSucceed(SpotifyApi spotifyApi) throws IOException {
            GetAvailableGenreSeedsRequest request = spotifyApi.getAvailableGenreSeeds().build();
            try {
                String[] Genres = request.execute();
                for (String g: Genres) {
                    genres.add(g);

                }

            } catch (SpotifyWebApiException e) {
                throw new RuntimeException(e);
            }  catch (org.apache.hc.core5.http.ParseException e) {
                throw new RuntimeException(e);
            }
        }

        @Override
        public void onAuthFailed() {

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


<center>
    <div class="vertical-center">

        <div class="container bg-dark ">
            <table class="table table-hover table-dark">
                <thead>
                <tr>
                    <th>My Playlists</th>
                </tr>
                </thead>
                <tbody>

                    <%for(Playlist p : new Dao().GetUserPlaylists(user.getUser_id())) { %>
                    <tr class="table-row"data-href="Playlist?playlist_id=<%=p.getPlaylist_id()%>">

                        <td>
                        <div class="row">
                            <div class="col-9">
                                <%=p.getPlaylist_name()%>
                            </div>
                            <div class="col-3">
                                <a href="./?delete_playlist=<%=p.getPlaylist_id()%>" class="btn btn-outline-danger"><i class="bi bi-trash3"></i>
                                    Delete</a>
                            </div>
                        </div>
                        </td>
                    </tr>
                            <%}%>

                <tr>
                    <%String target = "#modalUpgradeAccount";
                        if(new Dao().isUserPremium(user.getUser_id()) || new Dao().GetUserPlaylistCount(user.getUser_id())<3)
                    { target ="#modalPlaylistForm";}
                    %>
                    <td><a data-toggle="modal" data-target="<%=target%>" class="btn btn-success">Add Playlist</a></td>
                </tr>
                </tbody>
            </table>
        </div>

    </div>

</center>






<!-- Playlist Modal -->
<div class="modal fade" id="modalPlaylistForm" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <form action="CreatePlaylist" method="post">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Create Playlist</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <h3>Playlist Name</h3>
                <input type="text" required class="form-control" id="playlist_name" name="playlist_name" aria-describedby="emailHelp" placeholder="Playlist Name">
                <link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/bbbootstrap/libraries@main/choices.min.css">
                <script src="https://cdn.jsdelivr.net/gh/bbbootstrap/libraries@main/choices.min.js"></script>

                <br>
                <h3>Genres</h3>

                <div class="row d-flex  mt-100">
                    <div class="col-md-12">
                        <select id="choices-multiple-remove-button" name="genres" multiple>

                    <%for (String g:genres){%>
                    <option value="<%=g%>"><%=g%></option>
                    <%}%>
                    </select> </div>
            </div>


            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                <input type="submit" class="btn btn-success" value="Save changes">
            </div>

        </div>
        </form>
    </div>
</div>

<!-- Upgrade Account Modal -->
<div class="modal fade" id="modalUpgradeAccount" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel2" aria-hidden="true">
    <div class="modal-dialog" role="document">

            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel2">Create Playlist</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <p>As a free user you can't create more than 3 playlists.</p>
                    <p>In order to do so you have to upgrade to a Premium Account.</p>

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    <a href="Account" class="btn btn-success"> Upgrade account</a>
                </div>

            </div>

    </div>
</div>


<script>$(document).ready(function(){

    var multipleCancelButton = new Choices('#choices-multiple-remove-button', {
        removeItemButton: true,
        maxItemCount:5,
        searchResultLimit:5,
        renderChoiceLimit:5
    });


});</script>
<script>
    $(document).ready(function($) {
        $(".table-row").click(function() {
            window.document.location = $(this).data("href");
        });
    });
</script>

</body>
</html>
