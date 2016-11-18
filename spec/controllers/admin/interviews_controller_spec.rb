require "rails_helper"

describe Admin::InterviewsController, type: :controller do
  render_views

  # fix for "IOError: closed stream" error
  let(:file) { File.open(File.join(Rails.root, '/spec/fixtures/300px.jpg')) }
  after { file.close }

  describe 'ImageField' do
    it 'GET #new renders image uploading form' do
      process :new, method: :get

      expect(response.body).to include(
        '<label for="interview_image">Image</label>',
        '<input type="file" name="interview[image]" id="interview_image" />'
      )
    end

    it 'GET #index renders uploaded image' do
      interview = create :interview, image: file

      process :index, method: :get

      expect(response.body).to include(
        '<td class="cell-data cell-data--image-field">',
        "<img src=\"#{interview.image.url}",
        '<img src="memory://' # ensure we use Memory storage in specs
      )
    end

    it 'GET #edit renders image uploading form' do
      interview = create :interview, image: file

      process :edit, method: :get, params: { id: interview.id }

      expect(response.body).to include(
      '<label for="interview_image">Image</label>',
      '<input type="file" name="interview[image]" id="interview_image" />'
      )
    end

    it 'GET #edit renders image uploading form' do
      interview = create :interview, image: file

      process :show, method: :get, params: { id: interview.id }

      expect(response.body).to include(
        '<dd class="attribute-data attribute-data--image-field"',
        "<img width=\"120\" src=\"#{interview.image.url}\""
      )
    end
  end
end
