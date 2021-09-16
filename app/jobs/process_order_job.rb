# frozen_string_literal: true

class ProcessOrderJob < ApplicationJob
  include Rails.application.routes.url_helpers
  queue_as :default

  def perform(order_id)
    @order = Order.find(order_id)
    update_order
    send_order_confirmation
    send_gift_certificates
    # Not delivery to do if only trees in the order
    @order.delivered! if @order.tree_only_and_email?
  end

  private

  def update_order
    @order.update(payment_date: Time.zone.now, total_price: @order.ttc_price_all_included,
                  delivery_fees: @order.current_delivery_fees)
  end

  def send_order_confirmation
    ClientMailer.with(order: @order).order_confirmation.deliver_later
  end

  def send_gift_certificates
    @order.line_items.to_deliver_by_email.each do |line_item|
      RecipientMailer.with(line_item: line_item).gift_certificate.deliver_later
    end
  end
end
