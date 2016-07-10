describe GameModelHelpers do
  it 'can turn a long description into a short description' do
    long_description = %(
      I am a description that is over 200 characters long.
      Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec eget ligula justo.
      Ut semper libero vel neque ultrices venenatis. Vestibulum ante ipsum primis in.
      faucibus orci luctus et ultrices posuere cubilia Curae; Donec a au.
    )
    game = create(:game, long_description: long_description)
    shortened_description = %(I am a description that is over 200 characters long. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec eget ligula justo. Ut semper libero vel neque ultrices ... [<a href="/games/#{game.id}"><i>more</i></a>])
    expect(game.shortened_description).to eq shortened_description
  end
end
