# frozen_string_literal: true

# Update and resend certificates to clients who ordered trees from
# tree_plantations with incomplete informations
class UpdateCertificatesJob < ApplicationJob
  include Rails.application.routes.url_helpers
  queue_as :default

  def perform(tree_plantation_id)
    @tree_plantation = TreePlantation.find(tree_plantation_id)
    generate_certificates
    send_update_emails
  end

  private

  def generate_certificates
    @tree_plantation.line_items.paid.each do |line_item|
      line_item.generate_certificate
    end
  end

  def send_update_emails
    @tree_plantation.orders.paid.each do |order|
      ClientMailer.with(order: order).tree_plantation_update.deliver_later
    end
  end
end
