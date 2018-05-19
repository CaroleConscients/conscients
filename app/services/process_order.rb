# frozen_string_literal: true

class ProcessOrder
  def initialize(order)
    @order = order
    @view = ActionView::Base.new('app/views', {}, ActionController::Base.new)
    @view.extend(ApplicationHelper)
    @view.extend(Rails.application.routes.url_helpers)
  end

  def perform
    update_order
    generate_invoice
    # generate_certificate if some
    # send email recap order --> after callback un des jobs
    # send certicates to recipients if needed
  end

  private

  def update_order
    @order.update(payment_date: Time.zone.now, total_price: @order.ttc_price_all_included,
                  delivery_fees: @order.current_delivery_fees)
  end

  def generate_invoice
    pdf = WickedPdf.new.pdf_from_string(
      @view.render(
        template: 'invoices/new',
        locals: { '@order': @order, '@delivery_address': @order.delivery_address,
                  '@billing_address': @order.billing_address }
      )
    )
    @order.invoice.attach(io: StringIO.new(pdf), filename: "invoice##{@order.id}.pdf",
                          content_type: 'application/pdf')
  end
end
