describe Page do
  let_and_create! :game

  it 'fails for testing travis' do
    expect(false).to eq true
  end

  it 'views home' do
    visit root_path
    expect(page).to have_content 'Recently Added Games'
    expect(page).to have_content game.name
  end
end
