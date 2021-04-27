require 'rails_helper'

RSpec.describe 'ShortUrls', type: :request do
  before(:all) do
    delete_all_tables
    Link.create(url: 'https://catdog.com/')
  end

  describe 'GET /' do
    it 'redirects_to original url' do
      get "/#{Link.first.short_url}a"
      expect(response).to redirect_to('https://catdog.com/')
    end
  end
end
