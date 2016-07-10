describe Creator do
  let_and_create! :creator

  it 'views index' do
    visit creators_path
    expect(page).to have_content 'Creators'
    expect(page).to have_content creator.name
  end

  it 'views single' do
    visit creator_path(creator)
    expect(page).to have_content creator.name
  end
end
