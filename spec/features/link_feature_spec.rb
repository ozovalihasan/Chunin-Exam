require 'rails_helper'

RSpec.describe 'link', type: :system do
  it 'is created by using form on the index page of whiistles' do
    visit_root
    fill_in('url', with: 'https://catdog.com/')
    click_button('Shorten Link')
    page.has_content?

    expect(page).to have_content(Link.last.short_url)
  end
end
