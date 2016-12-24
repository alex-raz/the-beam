require 'rails_helper'

RSpec.describe PagesController, type: :controller do
  render_views

  specify 'success response' do
    pages = [:home, :ambassador, :buy, :impressum, :solar_panel_art]

    pages.map do |page|
      process page, method: :get

      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #home' do
    let(:file) { File.open(File.join(Rails.root, '/spec/fixtures/300px.png')) }
    let(:x1200_file) { File.open(File.join(Rails.root, '/spec/fixtures/300px.jpg')) }
    let(:cropped_file) { File.open(File.join(Rails.root, '/spec/fixtures/300px_cropped.jpg')) }

    before do
      # stub images processing
      allow_any_instance_of(InterviewImageUploader)
        .to receive(:process).and_wrap_original do |_m, io, context|
          { x1200: x1200_file, cropped: cropped_file } if context[:phase] == :store
        end
    end

    it 'renders interviews' do
      interview = create :interview, image: file

      process :home, method: :get

      expect(response.body).to include(
        "<img class=\"interview__img\" src=\"#{interview.image[:cropped].url}\"",
        "<h4 class=\"interview__header\">#{interview.interviewee_full_name}</h4>",
        "<p class=\"interview__synopsis\">#{interview.interviewee_synopsis}",
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
        "<cite class=\"testimonial__cite\">",
        "<a href=\"#{testimonial.reader_link}\">#{testimonial.reader_full_name}</a>"
      )
    end
  end
end
