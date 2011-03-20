# ULTRA STEP: MAKE MULTIPLE LAYER SUPPORT = MULTIPLE GAME BOARDS

class PdxPacman < Sinatra::Base

  get '/games/:layer_id/join' do
    @game = Game.find_or_create :layer_id => params[:layer_id]
    erb :join
  end

  post '/games/:layer_id/join.json' do
    content_type 'application/json'
    #  params[:layer_id] comes from JOIN button
    # Also: params[:access_token]
    #  generate shared_token
    #  subscribe the player to the layer
    #  pick a team and record
    #  send message to user indicating team
  end

  get '/?' do
    erb :'index'
  end

  post '/trigger' do
    body = SymbolTable.new JSON.parse(request.body)
    @player = Player.first_or_create :geoloqi_id => body.user.user_id
    @player.profile_image = body.user.profile_image
    @player.name = body.user.name
    @player.save

    if body.place.extra.active.to_i == 1
      Geoloqi.post params[:oauth_token], "place/update/#{body.place.place_id}"
      @player.add_points body.place.extra.points if body.place.extra && body.place.extra.points
      @player.send_message params[:oauth_token], "You ate a dot! #{body.place.extra.points} points"
    end
  end

  get '/scores.json' do
    content_type 'application/json'
    players = Player.all.collect{|player| {:geoloqi_id => player.id, 
                                           :score => player.points_cache, 
                                           :name => player.name, 
                                           :profile_image => player.profile_image}}
    players.to_json
  end

  get '/setup.json' do
    response = Geoloqi.post params[:oauth_token], 'place/list', {:layer_id => layer_id}
    places = []
    response['places'].each do |place|
      places << {:place_id => place['place_id'],
                 :latitude => place['latitude'],
                 :longitude => place['longitude'],
                 :active => place['extra']['active']}
    end
    places.to_json
  end
end