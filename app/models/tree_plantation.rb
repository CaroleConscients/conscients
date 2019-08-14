# frozen_string_literal: true

# == Schema Information
#
# Table name: tree_plantations
#
#  id                    :bigint(8)        not null, primary key
#  project_name          :string           not null
#  project_type          :string
#  partner               :string           not null
#  plantation_uuid       :string
#  base_certificate_uuid :string           not null
#  latitude              :decimal(11, 8)   not null
#  longitude             :decimal(11, 8)   not null
#  tree_specie           :string
#  producer_name         :string
#  trees_quantity        :integer          default(0), not null
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  base_tree_quantity    :integer
#  is_full               :boolean          default(FALSE)
#  certificate_counter   :integer          default(0), not null
#

class TreePlantation < ApplicationRecord
  has_many :line_items, dependent: :destroy
  has_many :orders, through: :line_items
  has_one_attached :klm_file
  has_many :product_tree_plantations, dependent: :destroy
  has_many :product, through: :product_tree_plantations

  # Initialize quantity (base tree quantity is the initial quantity in the plantation)
  before_create :match_base_tree_quantity
  # Check if Tree Plantation infos finalized and send emails if necessary
  before_save :update_is_full_and_send_emails, unless: :is_full?
  before_update :alert_on_zero_quantity

  extend Mobility
  translates :project_type

  validates :project_name, :project_type, :base_certificate_uuid,
            :latitude, :longitude, :partner, presence: true
  validates :plantation_uuid, :tree_specie, :producer_name, presence: true, if: :is_full?
  validates :base_certificate_uuid, length: { maximum: 15 }
  validates :project_name, :project_type, :plantation_uuid, :tree_specie, :producer_name,
            :partner, length: { maximum: 40 }, allow_nil: true
  # replaced by LineItem#sufficient_plantation_stock
  # validates :trees_quantity, numericality: { greater_than_or_equal_to: 0 }

  default_scope { in_order }
  scope :in_order, -> { order(trees_quantity: :asc) }

  alias_attribute :quantity, :trees_quantity

  def self.admin_select
    all.map { |tp| ["#{tp.project_name} (id: #{tp.id}, qtty: #{tp.trees_quantity})", tp.id] }
  end

  def to_s
    project_name
  end

  # Finalized means with all the correct info to make it complete
  # (because can be created incomplete)
  # rubocop:disable Metrics/CyclomaticComplexity
  # rubocop:disable Metrics/PerceivedComplexity
  # rubocop:disable Metrics/AbcSize
  def finalized?
    project_name.present? && project_type.present? && base_certificate_uuid.present? &&
      latitude.present? && longitude.present? && trees_quantity.present? &&
      partner.present? && plantation_uuid.present? && tree_specie.present? &&
      producer_name.present?
  end
  # rubocop:enable Metrics/AbcSize
  # rubocop:enable Metrics/CyclomaticComplexity
  # rubocop:enable Metrics/PerceivedComplexity

  def generate_certificate_number
    update certificate_counter: certificate_counter + 1
    base_certificate_uuid + "-#{format '%03d', certificate_counter}"
  end

  def match_base_tree_quantity
    self.base_tree_quantity = trees_quantity
  end

  # rubocop:disable Metrics/AbcSize
  def alert_on_zero_quantity
    return unless quantity != quantity_was && quantity_was.positive? && quantity.zero?

    ContactMailer.with(
      subject: "Stock alert TreePlantation: #{project_name} - product_ids: #{product_ids.join('|')}",
      message: "The quantity reached 0. This could impact products with the ids:  #{product_ids.join('|')}"
    ).stock_alert.deliver_later
  end
  # rubocop:enable Metrics/AbcSize

  private

  def update_is_full_and_send_emails
    return unless finalized?

    update(is_full: true)
    UpdateCertificatesJob.perform_later(id) unless new_record?
  end
end
