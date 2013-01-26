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
    self.class.associations.each do |association|
      attributes[association] = self.send(association).map(&:as_json)
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

    attribute_names ||= self.instance_variable_get(:@attribute_names) || []
    attribute_names += new_attrs.map(&:to_sym)
    self.instance_variable_set(:@attribute_names, attribute_names)
  end

  def attribute_names
    self.instance_variable_get(:@attribute_names)
  end

  def has_many(name)
    klass = Object.const_get(name.to_s.classify)
    define_method(name) do
      klass.all(:parent_id => self.to_id, :parent_key => self.class.key)
    end

    associations ||= self.instance_variable_get(:@associations) || []
    associations << name
    self.instance_variable_set(:@associations, associations)
  end

  def associations
    self.instance_variable_get(:@associations) || []
  end

  def set_key(key)
    self.instance_variable_set(:@key, key.to_s)
  end

  def key
    key = self.instance_variable_get(:@key)
    key || self.name.tableize
  end

  def set_path(path)
    self.instance_variable_set(:@path, path)
  end

  def path
    self.instance_variable_get(:@path)
  end

  def all(options = {})
    resource_path = [options[:parent_id], path].compact.join("/")
    raw_data = espn_connection.get(resource_path)
    if options[:parent_key]
      raw_data = raw_data[options[:parent_key].to_s].first
    end
    data = raw_data[self.key]
    data.map { |params| self.new(normalize_keys(params)) }
  end

  def first
    all.first
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
