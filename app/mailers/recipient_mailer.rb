# frozen_string_literal: true

class RecipientMailer < ApplicationMailer
  def gift_certificate
    @line_item = params[:line_item]
    certificate =
      begin
        @line_item.certificate.download
      rescue ActiveStorage::FileNotFoundError
        @line_item.generate_certificate
      end
    attachments['certificate.pdf'] = certificate
    mail to: @line_item.delivery_email
  end
end
