package Api;

import org.apache.hc.core5.http.ParseException;
import se.michaelthelin.spotify.SpotifyApi;
import se.michaelthelin.spotify.exceptions.SpotifyWebApiException;
import se.michaelthelin.spotify.model_objects.credentials.ClientCredentials;
import se.michaelthelin.spotify.requests.authorization.client_credentials.ClientCredentialsRequest;

import java.io.IOException;
import java.util.concurrent.CancellationException;
import java.util.concurrent.CompletableFuture;
import java.util.concurrent.CompletionException;

public class SpotifyAuth {
    private static final String clientId = "ac17e01e4c8c47a192ecf426852d807d";
    private static final String clientSecret = "0d3c86d66f6d4f1dae14baf9f8b889fa";

    private static final SpotifyApi spotifyApi = new SpotifyApi.Builder()
            .setClientId(clientId)
            .setClientSecret(clientSecret)
            .build();
    private static final ClientCredentialsRequest clientCredentialsRequest = spotifyApi.clientCredentials()
            .build();

    public  void clientCredentials_Sync() {

        final ClientCredentials clientCredentials;
        try {
            clientCredentials = clientCredentialsRequest.execute();
            spotifyApi.setAccessToken(clientCredentials.getAccessToken());
            if(spotifyAuthListener!= null){spotifyAuthListener.onAuthSucceed(spotifyApi);}
        } catch (IOException | SpotifyWebApiException | ParseException e) {
            if(spotifyAuthListener!= null){spotifyAuthListener.onAuthFailed();}
        }

        // Set access token for further "spotifyApi" object usage



    }

    public static void clientCredentials_Async() {
        try {
            final CompletableFuture<ClientCredentials> clientCredentialsFuture = clientCredentialsRequest.executeAsync();

            // Thread free to do other tasks...

            // Example Only. Never block in production code.
            final ClientCredentials clientCredentials = clientCredentialsFuture.join();

            // Set access token for further "spotifyApi" object usage
            spotifyApi.setAccessToken(clientCredentials.getAccessToken());

            System.out.println("Expires in: " + clientCredentials.getExpiresIn());
        } catch (CompletionException e) {
            System.out.println("Error: " + e.getCause().getMessage());
        } catch (CancellationException e) {
            System.out.println("Async operation cancelled.");
        }
    }



    public interface SpotifyAuthListener
    {
        void onAuthSucceed(SpotifyApi s) throws IOException;
        void onAuthFailed();
    }
    SpotifyAuthListener spotifyAuthListener = null;

    public void setSpotifyAuthListener(SpotifyAuthListener listener)
    {
        this.spotifyAuthListener = listener;
        clientCredentials_Sync();
    }
}
