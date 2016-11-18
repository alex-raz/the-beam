require 'rails_helper'
require 'trix_editor_field'

describe ImageField do
  describe '#to_partial_path' do
    it 'returns a partial based on the page being rendered' do
      page = :show
      field = described_class.new(:anything, 'something', page)
      path = field.to_partial_path

      expect(path).to eq("/fields/image_field/#{page}")
    end
  end
end
