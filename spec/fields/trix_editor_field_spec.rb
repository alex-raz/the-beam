require 'rails_helper'
require 'trix_editor_field'

describe TrixEditorField do
  describe '#to_partial_path' do
    it 'returns a partial based on the page being rendered' do
      page = :show
      field = described_class.new(:anything, '<p>data</p>', page)

      path = field.to_partial_path

      expect(path).to eq("/fields/trix_editor_field/#{page}")
    end
  end

  describe '#raw_html' do
    it 'returns html_safe data' do
      field = described_class.new(:attribute, '<p>data</p>', :edit)

      expect(field.data.html_safe?).to be false # sanity check
      expect(field.raw_html.html_safe?).to be true
    end
  end
end
