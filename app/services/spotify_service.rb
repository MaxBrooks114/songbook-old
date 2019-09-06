class SpotifyService

  def authenticate!(client_id, client_secret, code)
    resp = Faraday.get("https://accounts.spotify.com/authorize") do |req|
      req.params['client_id'] = client_id
      req.params['client_secret'] =  client_secret
      req.params['grant_type'] = 'authorization_code'
      req.params['redirect_uri'] = "http://localhost:3000/auth"
      req.params['response_type'] = code
      req.params['scope'] = 'playlist-read-collaborative playlist-read-private user-read-private user-library-read'
    end
    body = JSON.parse(resp.body)
    body["access_token"]
end



end
