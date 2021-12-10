require 'rails_helper'
describe 'Studio index page' do
  before do
    @studio1 = Studio.create!(name:"Kelly's Studio", location:"Denver")
    @studio2 = Studio.create!(name:"Universal Studio", location:"LA")
    @movie1 = @studio1.movies.create!(title:"Harry Potter", creation_year: 2000, genre:"Magic")
    @movie2 = @studio1.movies.create!(title:"The Titanic", creation_year: 2002, genre:"Romance")
    @movie3 = @studio2.movies.create!(title:"Raiders of the Lost Ark", creation_year: 1981, genre: "Action/Adventure")
    visit "/studios"
  end

  it 'I see a each studios name and location' do
    expect(page).to have_content(@studio1.name)
    expect(page).to have_content(@studio2.name)
  end

  it 'underneath each studio, I see the titles of all of its movies.' do
    within "#studio-#{@studio1.id}" do
      expect(page).to have_content(@movie1.title)
      expect(page).to have_content(@movie2.title)
    end
    within "#studio-#{@studio2.id}" do
      expect(page).to have_content(@movie3.title)
      save_and_open_page
    end
  end
end
