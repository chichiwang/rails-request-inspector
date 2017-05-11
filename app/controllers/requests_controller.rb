class RequestsController < ApplicationController
  def index
    @headers = http_envs
    render json: JSON.pretty_generate(@headers)
  end

  private

  def log_request_headers
    logger.warn("request.headers >> #{http_envs}")
  end

  def http_envs
    @http_envs ||= {}.tap do |envs|
      request.headers.each do |key, value|
        envs[key] = value if key.downcase.starts_with?('http')
      end
    end
  end
end
