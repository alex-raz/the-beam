require 'rails_helper'

RSpec.describe PagesController, type: :controller do
  render_views

  specify "success response" do
    pages = [:home, :ambassador, :buy, :impressum, :solar_panel_art]

    pages.map do |page|
      get page

      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #home' do
    it 'renders interviews' do
      interview = create :interview

      get :home

      expect(response.body).to include(
        "<h4>#{interview.interviewee_full_name}</h4>",
        "<p class=\"title\">#{interview.interviewee_synopsis}",
        "href=\"#{interview.read_more_link}\">READ MORE"
      )
    end
  end
end
