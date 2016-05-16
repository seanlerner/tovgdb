json.array!(@games) do |game|
  json.extract! game, :id, :name, :website, :short_description, :long_description, :publish_date
  json.url game_url(game, format: :json)
end
