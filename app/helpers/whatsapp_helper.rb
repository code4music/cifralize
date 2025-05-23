# frozen_string_literal: true

module WhatsappHelper
  def whatsapp_api_url(phone)
    "https://api.whatsapp.com/send?phone=55#{format(phone)}" if valid?(phone)
  end

  private

  def valid?(wapp)
    !!(wapp =~ /(\(?\d{2}\)?\s)?(\d{4,5}-\d{4})/)
  end

  def format(wapp)
    wapp.gsub(/[^0-9,.]/, '')
  end
end
