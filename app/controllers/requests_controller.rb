class RequestsController < ApplicationController
  def index
    log_request_data
    render json: JSON.pretty_generate(request_data)
  end

  private

  def request_data
    @request_data ||= {
      headers: http_envs,
      method: request.method,
      url: request.original_url,
      ip: request.ip,
      remote_ip: request.remote_ip
    }
  end

  def log_request_data
    logger.warn("-- [Request Data] >>\n#{request_data}\n-- <<")
  end

  def http_envs
    @http_envs ||= {}.tap do |envs|
      request.headers.each do |key, value|
        envs[key] = value if key.downcase.starts_with?('http')
      end
    end
  end
end
