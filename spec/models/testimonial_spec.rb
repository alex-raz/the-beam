# == Schema Information
#
# Table name: testimonials
#
#  id               :integer          not null, primary key
#  content          :text
#  reader_full_name :string
#  reader_link      :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

require 'rails_helper'

RSpec.describe Testimonial, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:content) }
    it { is_expected.to validate_presence_of(:reader_full_name) }
  end
end
