# frozen_string_literal: true

# == Schema Information
#
# Table name: line_items
#
#  id                 :integer          not null, primary key
#  product_sku_id     :integer
#  order_id           :integer
#  tree_plantation_id :integer
#  quantity           :integer          default(1), not null
#  recipient_name     :string
#  recipient_message  :text
#  certificate_date   :date
#  certificate_number :string
#  delivery_email     :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
# Foreign Keys
#
#  fk_rails_...  (order_id => orders.id)
#  fk_rails_...  (product_sku_id => product_skus.id)
#  fk_rails_...  (tree_plantation_id => tree_plantations.id)
#

class LineItem < ApplicationRecord
  belongs_to :product_sku
  belongs_to :order
  belongs_to :tree_plantation, optional: true

  validates :quantity, presence: true, numericality: { greater_than_or_equal_to: 1 }
end