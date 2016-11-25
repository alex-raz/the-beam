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

class AdminUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  # :registerable, :recoverable, :trackable,
  devise :database_authenticatable, :lockable, :rememberable,  :validatable
end
