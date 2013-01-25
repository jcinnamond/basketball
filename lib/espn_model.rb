require 'espn_connection'

module ESPNModel
  def self.included(base)
    base.extend(ESPNModelDSL)
  end

  def initialize(params = {})
    @attributes = params.symbolize_keys
  end

  def as_json(options = {})
    attributes = {}
    self.class.attribute_names.each do |attr|
      attributes[attr] = self.send(attr)
    end
    attributes
  end
end

module ESPNModelDSL
  def attributes(*new_attrs)
    new_attrs ||= []

    new_attrs.each do |attr|
      define_method(attr) do
        @attributes[attr.to_sym]
      end
    end

    @@attribute_names ||= []
    @@attribute_names += new_attrs.map(&:to_sym)
  end

  def attribute_names
    @@attribute_names
  end

  def key(key)
    @@key = key
  end

  def all
    data = espn_connection.get("")[@@key.to_s]
    data.map { |params| self.new(normalize_keys(params)) }
  end

  def espn_connection
    @@espn_connection ||= ESPNConnection.instance
  end

  def normalize_keys(orig)
    return orig unless orig.is_a?(Hash)

    new_hash = {}
    orig.each_pair do |key, value|
      new_key = key.to_s.underscore
      new_hash[new_key] = if value.is_a?(Hash)
        normalize_keys(value)
      elsif value.is_a?(Array)
        value.map { |item| normalize_keys(item) }
      else
        value
      end
    end
    new_hash
  end
end
