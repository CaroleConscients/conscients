# frozen_string_literal: true

class ProcessOrderJob < ApplicationJob
  include Rails.application.routes.url_helpers
  queue_as :default

  def perform(order_id)
    @order = Order.find(order_id)
    update_order
    generate_invoice
    generate_certificates
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

  def generate_invoice
    pdf_html = ActionController::Base.new.render_to_string(
      template: 'invoices/new',
      locals: { '@order': @order, '@delivery_address': @order.delivery_address,
        '@billing_address': @order.billing_address },
      layout: 'layouts/pdf'
    )
    pdf = WickedPdf.new.pdf_from_string(pdf_html)
    @order.invoice.attach(io: StringIO.new(pdf), filename: "invoice##{@order.id}.pdf",
                          content_type: 'application/pdf')
  end

  def generate_certificates
    @order.line_items.each do |line_item|
      next if line_item.tree_plantation.nil?

      line_item.generate_certificate
    end
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
