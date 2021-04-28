require 'rails_helper'

RSpec.describe 'Links', type: :request do
  before(:all) do
    delete_all_tables
  end

  it 'redirects to original url if short_url exists' do
    original_url = 'https://catdog.com/'
    link = Link.create(url: original_url)
    get "/#{link.short_url}"
    expect(response).to redirect_to(original_url)
    expect(status).to eq(302)
  end

  it 'redirects to root path if short_url doesn\'t exist' do
    get "/#{Faker::Lorem.word}"
    expect(response).to redirect_to(root_path)
    expect(status).to eq(302)
  end

  it 'returns new template' do
    get '/links/new'
    expect(status).to eq(200)
  end

  it 'creates a new link and redirects to root path' do
    expect(Link.all.size).to eq(0)
    post '/links', params: { link: { url: 'https://catdog.com/' } }

    expect(Link.all.size).to eq(1)
    expect(response).to redirect_to(root_path + "?short_url=#{Link.first.short_url}")
    expect(status).to eq(302)
  end
end
