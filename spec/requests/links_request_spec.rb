require 'rails_helper'

RSpec.describe 'Links', type: :request do
  before(:all) do
    delete_all_tables
  end

  it 'redirects to original url and save visiting time if short_url exists' do
    original_url = 'https://catdog.com/'
    link = Link.create(url: original_url)
    expect(Visit.all.size).to eq(0)

    get "/#{link.short_url}"

    expect(response).to redirect_to(original_url)
    expect(status).to eq(302)
    expect(Visit.all.size).to eq(1)
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

  it 'creates a new link and returns short form of url' do
    expect(Link.all.size).to eq(0)

    post '/links', params: 'https://catdog.com/'

    expect(Link.all.size).to eq(1)
    expect(response.stream.body).to eq(request.base_url + "/#{Link.first.short_url}")
    expect(status).to eq(200)
  end

  it 'returns a warning if url is not valid' do
    post '/links', params: 'catdog.com/'

    expect(response.stream.body).to eq("The input is not a valid url. (Don't forget to add 'http' or" \
                                                  " 'htpps' at the beginning of your url)")
    expect(status).to eq(200)
  end
end
