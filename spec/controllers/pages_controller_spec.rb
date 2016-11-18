require 'rails_helper'

RSpec.describe PagesController, type: :controller do
  render_views

  specify "success response" do
    pages = [:home, :ambassador, :buy, :impressum, :solar_panel_art]

    pages.map do |page|
      process page, method: :get

      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #home' do
    it 'renders interviews' do
      interview = create :interview

      process :home, method: :get

      expect(response.body).to include(
        "<h4>#{interview.interviewee_full_name}</h4>",
        "<p class=\"title\">#{interview.interviewee_synopsis}",
        "href=\"#{interview.read_more_link}\">READ MORE"
      )
    end
  end

  describe 'GET #buy' do
    it 'renders testimonials' do
      testimonial = create :testimonial

      process :buy, method: :get

      expect(response.body).to include(
        testimonial.content,
        "<cite><a href=\"#{testimonial.reader_link}\">#{testimonial.reader_full_name}</a></cite>"
      )
    end
  end
end
