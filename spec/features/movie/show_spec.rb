require 'rails_helper'
describe 'Movie show page' do
  before do
    @studio1 = Studio.create!(name:"Kelly's Studio", location:"Denver")
    @studio2 = Studio.create!(name:"Universal Studio", location:"LA")
    @movie1 = @studio1.movies.create!(title:"Harry Potter", creation_year: 2000, genre:"Magic")
    @movie2 = @studio1.movies.create!(title:"The Titanic", creation_year: 2002, genre:"Romance")
    @movie3 = @studio2.movies.create!(title:"Raiders of the Lost Ark", creation_year: 1981, genre: "Action/Adventure")
    @actor2 = Actor.create!(name:"Josh", age: 29)
    @actor1 = Actor.create!(name:"Kara", age: 23)
    @actor3 = Actor.create!(name:"Jana", age: 54)
    @movie1_actor1 = ActorMovie.create!(movie: @movie1, actor: @actor1)
    @movie1_actor2 = ActorMovie.create!(movie: @movie1, actor: @actor2)
    @movie1_actor3 = ActorMovie.create!(movie: @movie1, actor: @actor3)
    @movie2_actor1 = ActorMovie.create!(movie: @movie2, actor: @actor1)
    @movie2_actor3 = ActorMovie.create!(movie: @movie2, actor: @actor3)
    @movie3_actor2 = ActorMovie.create!(movie: @movie3, actor: @actor2)
    @movie3_actor1 = ActorMovie.create!(movie: @movie3, actor: @actor1)
  end

  it 'I see the movies title, creation year, and genre' do
    visit "/movies/#{@movie1.id}"
    expect(page).to have_content(@movie1.title)
    visit "/movies/#{@movie2.id}"
    expect(page).to have_content(@movie2.creation_year)
    visit "/movies/#{@movie3.id}"
    expect(page).to have_content(@movie3.genre)
  end

  it 'I see a list of all its actors from youngest to oldest.' do
    visit "/movies/#{@movie1.id}"
    expect(page).to have_content(@actor1.name)
    expect(page).to have_content(@actor2.name)
    expect(page).to have_content(@actor3.name)
    expect(@actor1.name).to appear_before(@actor2.name)
  end

  it 'I see the average age of all of the movies actors' do
    visit "/movies/#{@movie1.id}"
    expect(page).to have_content("Average age of Movie Actors: 35")
  end

  it 'I do not see any actors listed that are not part of the movie' do
    visit "/movies/#{@movie2.id}"
    expect(page).to_not have_content(@actor2.name)
  end

  it 'I see a form to add an actor to this movie' do
    visit "/movies/#{@movie2.id}"
    expect(page).to have_content("Add actor to this movie")
    expect(page).to have_button('Add Actor')
  end

  it 'Can add an actor to the movie' do
    visit "/movies/#{@movie2.id}"
    fill_in 'name', with: 'Josh'
    save_and_open_page
    click_button 'Add Actor'
    expect(current_path).to eq("/movies/#{@movie2.id}")
    expect(page).to have_content(@actor2.name)
  end
end
