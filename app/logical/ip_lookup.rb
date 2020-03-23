# API client for https://ipregistry.co/

class IpLookup
  extend Memoist

  attr_reader :ip_addr, :api_key, :cache_duration

  def initialize(ip_addr, api_key: Danbooru.config.ip_registry_api_key, cache_duration: 1.day)
    @ip_addr = ip_addr
    @api_key = api_key
    @cache_duration = cache_duration
  end

  def info
    return {} unless api_key.present?
    response = Danbooru::Http.cache(cache_duration).get("https://api.ipregistry.co/#{ip_addr}?key=#{api_key}")
    return {} if response.status != 200
    json = response.parse.deep_symbolize_keys.with_indifferent_access
    json
  end

  def is_proxy?
    info[:security].present? && info[:security].values.any?
  end

  memoize :info, :is_proxy?
end
