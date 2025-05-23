# frozen_string_literal: true

require 'net/http'
require 'uri'
require 'json'

def notify_slack(message)
  webhook_url = ENV.fetch('SLACK_WEBHOOK_URL', nil)
  return unless webhook_url

  uri = URI.parse(webhook_url)
  header = { 'Content-Type': 'application/json' }
  payload = { text: message }.to_json

  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = true

  request = Net::HTTP::Post.new(uri.request_uri, header)
  request.body = payload

  response = http.request(request)
  puts "Slack notification response: #{response.body}" if Rails.env.development?
end
