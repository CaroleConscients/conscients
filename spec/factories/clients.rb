# frozen_string_literal: true
# == Schema Information
#
# Table name: clients
#
#  id                     :bigint(8)        not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  first_name             :string
#  last_name              :string
#  phone_number           :string
#  newsletter_subscriber  :boolean          default(TRUE)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  provider               :string
#  uid                    :string
#  stripe_customer_id     :string
#  invitation_token       :string
#  invitation_created_at  :datetime
#  invitation_sent_at     :datetime
#  invitation_accepted_at :datetime
#  invitation_limit       :integer
#  invited_by_type        :string
#  invited_by_id          :bigint(8)
#  invitations_count      :integer          default(0)
#  can_debug              :boolean          default(FALSE), not null
#  session_token          :string           default("3a3f286bca8e58c0a369556b3c362bba")
#

FactoryBot.define do
  factory :client do
    first_name { 'Default' }
    last_name  { 'Default' }
    email { 'jd@gmail.com' }
  end
end
