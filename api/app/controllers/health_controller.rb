# frozen_string_literal: true
require "net/http"
class HealthController < ApplicationController
  def index
    db_ok     = db_healthy?
    ollama_ok = ollama_healthy?

    render json: { ok: db_ok && ollama_ok, db: db_ok, ollama: ollama_ok }
  end

  private

  def db_healthy?
    ActiveRecord::Base.connection_pool.with_connection do |c|
      c.execute("SELECT 1")
    end
    true
  rescue => e
    Rails.logger.warn("healthz db error: #{e.class}: #{e.message}")
    false
  end

  def ollama_healthy?
    url = ENV["OLLAMA_URL"]
    return false if url.to_s.empty?

    uri = URI.join(url, "/api/tags")
    res = Net::HTTP.get_response(uri)
    res.is_a?(Net::HTTPSuccess)
  rescue => e
    Rails.logger.warn("healthz ollama error: #{e.class}: #{e.message}")
    false
  end
end
