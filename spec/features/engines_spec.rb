describe Engine do
  let_and_create! :engine

  it 'views index' do
    visit engines_path
    expect(page).to have_content 'Engines'
    expect(page).to have_content engine.name
  end

  it 'views single' do
    game = create(:game, engine: engine)
    visit engine_path(engine)
    expect(page).to have_content engine.name
    expect(page).to have_content game.name
  end
end
