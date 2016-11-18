require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe 'reader_cite' do
    context 'when testimonial has a reader link' do
      it 'returns link_to' do
        testimonial = create :testimonial, reader_link: 'http://example.com'
        expected_link = link_to(testimonial.reader_full_name, testimonial.reader_link)

        expect(helper.reader_cite(testimonial)).to eq expected_link
      end
    end

    context 'when testimonial has no reader link' do
      it 'returns reader full name only' do
        testimonial = create :testimonial, reader_link: nil

        expect(helper.reader_cite(testimonial)).to eq testimonial.reader_full_name
      end
    end
  end
end
