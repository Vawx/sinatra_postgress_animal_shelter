require 'capybara/rspec'
require './app'
Capybara.app = Sinatra::Application
set(:show_exceptions, false)

feature 'adding a new animal' do
  scenario 'allows a user to click a animal and see their info' do
    visit '/'
    click_link 'Add New Animal'
    fill_in 'name', with: 'Spot'
    click_button 'Add Animal'
    expect(page).to have_content('Spot')
  end
end

feature 'adding a new customer' do
  scenario 'allows a user to click a customer and see their info' do
    visit '/'
    click_link 'Add New Customer'
    fill_in 'name', with: 'Francis'
    click_button 'Add Customer'
    expect(page).to have_content('Francis')
  end
end
