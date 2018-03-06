# frozen_string_literal: true

# 存储 ip 结果
class IpAddressResult
  attr_accessor :answer, :main_location, :location_raw, :markup
  def initialize(dict = {})
    dict.each do |k, v|
      send("#{k}=", v)
    end
  end

  def to_hash
    instance_variables.map do |var|
      [var[1..-1].to_sym, instance_variable_get(var)]
    end.to_h
  end
  alias to_h to_hash
end
