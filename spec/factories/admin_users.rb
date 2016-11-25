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

FactoryGirl.define do
  factory :admin_user do
    sequence(:email)  { |n| "admin_email#{n}@example.com" }
    password '123456'
  end
end
