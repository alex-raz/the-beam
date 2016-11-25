# == Schema Information
#
# Table name: admin_users
#
#  id                  :integer          not null, primary key
#  email               :string           default(""), not null
#  encrypted_password  :string           default(""), not null
#  remember_created_at :datetime
#  failed_attempts     :integer          default(0), not null
#  locked_at           :datetime
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

require 'rails_helper'

RSpec.describe AdminUser, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
