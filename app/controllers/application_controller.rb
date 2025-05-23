# frozen_string_literal: true

# ApplicationController
class ApplicationController < ActionController::Base
  protect_from_forgery
  before_action :authenticate_user!

  rescue_from StandardError, with: :notify_slack_of_error

  private

  def notify_slack_of_error(exception)
    user_email = current_user&.email || 'Unknown User'
    error_location = exception.backtrace.first
    message = "An error occurred: #{exception.message}\n" \
              "User: #{user_email}\n" \
              "URL: #{request.url}\n" \
              "HTTP Verb: #{request.method}\n" \
              "Error Location: #{error_location}"

    notify_slack(message)
    raise exception
  end
end
