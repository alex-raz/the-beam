require 'rails_helper'

RSpec.describe PagesController, type: :controller do
  describe "static pages" do
    specify "success response" do
      pages = [:home, :ambassador, :buy, :impressum, :solar_panel_art]

      pages.map do |page|
        get page
        expect(response).to have_http_status(:success)
      end
    end
  end
end
