# frozen_string_literal: true

class ClientMailer < ApplicationMailer
  # Sent when bank transfer payment selected
  def bank_account_details
    @order = params[:order]
    attachments['bank_account_details_conscients.pdf'] =
      File.read(Rails.root.join('app', 'assets', 'images', 'bank_account_details_conscients.pdf'))
    mail to: @order.client_email
  end

  def order_confirmation
    @order = params[:order]

    invoice = @order.generate_invoice
    attachments['invoice.pdf'] = invoice

    certificate_files = @order.generate_certificates
    certificate_files.each do |line_item_id, certificate_file|
      attachments["certificate##{line_item_id}.pdf"] = certificate_file
    end

    mail to: @order.delivery_address_email
  end

  def order_delivery
    @order = params[:order]
    mail to: @order.client_email
  end

  def tree_plantation_update
    @order = params[:order]
    mail to: @order.client_email
  end
end
