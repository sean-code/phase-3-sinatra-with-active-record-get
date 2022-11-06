class ApplicationController < Sinatra::Base
    # Add this line to set the Content-Type header for all responses
    set :default_content_type, 'application/json'

  get '/' do
    { message: "Hello world" }.to_json
  end
  get '/games' do
    # get all the games from the database
    games = Game.all.order(:title).limit(10)
    # return a JSON response with an array of all the game data
    games.to_json
  end

  # get '/reviews' do
  #   reviews=Review.all.order(:title)
  #   reviews.to_json
  # end
  get '/games/:id' do
    game = Game.find(params[:id])

    # include associated reviews in the JSON response
    game.to_json(include: { reviews: { include: :user } })
  end

end
