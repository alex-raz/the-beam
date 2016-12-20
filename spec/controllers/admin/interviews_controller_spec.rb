require 'rails_helper'

describe Admin::InterviewsController, type: :controller do
  render_views

  let(:file_as_form_attr) do
    Rack::Test::UploadedFile.new(File.join(Rails.root, '/spec/fixtures/900px.jpg'))
  end
  let(:file) { File.open(File.join(Rails.root, '/spec/fixtures/300px.png')) }
  let(:x1200_file) { File.open(File.join(Rails.root, '/spec/fixtures/300px.jpg')) }
  let(:cropped_file) { File.open(File.join(Rails.root, '/spec/fixtures/300px_cropped.jpg')) }

  # authenticate admin user before each action
  let(:admin_user) { create :admin_user }
  before do |example|
    sign_in admin_user

    # stub images processing
    unless example.metadata[:skip_processing_stub]
      allow_any_instance_of(InterviewImageUploader)
        .to receive(:process).and_wrap_original do |_m, _io, context|
          { x1200: x1200_file, cropped: cropped_file } if context[:phase] == :store
        end
    end
  end

  describe 'overriding standard actions' do
    describe 'POST #create' do
      context 'when success' do
        it 'renders #crop view' do
          process(
            :create,
            method: :post,
            params: { interview: attributes_for(:interview, image: file_as_form_attr) }
          )

          expect(response.body).to include('<h1 class="header__heading">Crop interview image</h1>')
        end
      end
    end

    describe 'PATCH #update' do
      context 'when success' do
        it 'renders #crop view', skip_processing_stub: true do
          interview = create :interview, image: file

          process(
            :update,
            method: :patch,
            params: { id: interview.id, interview: { image: file_as_form_attr } }
          )

          expect(response.body).to include('<h1 class="header__heading">Crop interview image</h1>')
        end
      end

      context 'when cropping' do
        it 'generates cropped version', skip_processing_stub: true do
          interview = create :interview, image: file

          process(
            :update,
            method: :patch,
            params: {
              id: interview.id,
              interview: { crop_x: '0', crop_y: '0', crop_w: '166', crop_h: '166' }
            }
          )

          expect(interview.reload.image.keys).to eq [:original, :x1200, :cropped]
        end
      end
    end
  end

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
        "<img class=\"round-img\" src=\"#{interview.image[:cropped].url}",
        '<img class="round-img" src="memory://' # ensure we use Memory storage in specs
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
        "<img width=\"166\" class=\"round-img\" src=\"#{interview.image[:cropped].url}\""
      )
    end
  end
end
