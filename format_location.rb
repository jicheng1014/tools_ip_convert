# frozen_string_literal: true

require 'qqwry'
require_relative './ip_address_result'

module FormatLocation
  class << self
    def query(ip)
      init_data
      # ip 校验 符合正则
      return failure_result unless ip_correct?(ip)
      data = QQWry::Database.new('qqwry.dat').query(ip)
      return failure_result if data.nil?
      main_location = format_province(data.country)
      IpAddressResult.new(answer: true,
                          main_location: main_location,
                          location_raw: data.country,
                          markup: data.area)
    end

    private

    def failure_result
      IpAddressResult.new(
        answer: false
      )
    end

    def ip_correct?(ip)
      return true if /^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$/.match? ip
      localhost?(ip)
    end

    def localhost?(ip)
      %w[localhost ::1].include? ip
    end

    def format_province(province)
      answer = @provinces_standard.find do |goal|
        /^#{goal}/.match? province
      end
      return answer unless answer.nil?

      answer = @provinces_abbr_dict.find do |key, _val|
        /^#{key}/.match? province
      end&.last
      answer || province
    end

    def init_data
      @provinces_standard ||= %w[北京市 天津市 河北省 山西省 内蒙古自治区 辽宁省 吉林省 黑龙江省 上海市 江苏省 浙江省 安徽省 福建省 江西省 山东省 河南省 湖北省 湖南省 广东省 广西壮族自治区 海南省 重庆市 四川省 贵州省 云南省 西藏自治区 陕西省 甘肃省 青海省 宁夏回族自治区 新疆维吾尔自治区 台湾省 香港特别行政区 澳门特别行政区].freeze

      @provinces_abbr_dict ||= Hash[@provinces_standard.map do |s|
        [s.gsub(/市|省|自治区|回族|维吾尔|特别行政区|壮族/, ''), s]
      end].freeze
    end
  end
end
