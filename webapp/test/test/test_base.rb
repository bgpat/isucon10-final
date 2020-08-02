require 'test/unit'
require 'net/http'
$LOAD_PATH << File.join(File.expand_path('../', __FILE__), 'lib')
require 'routes'

class TestBase < Test::Unit::TestCase
  include Xsuportal::Routes

  attr_reader :response, :status
  def setup
    @host = ENV.fetch('HOST', 'localhost')
    @port = ENV.fetch('PORT', 9292)
    @response = nil
    @status = nil
    @cookie = {}
  end

  def http_get(path, headers={})
    request = Net::HTTP::Get.new(path)
    unless headers.empty?
      headers.each do |key, value|
        request[key] = value
      end
    end
    Net::HTTP.start(@host, @port) do |http|
      http.request(request)
    end
  end

  def request_pb(method, path, payload={})
    route = "#{method.upcase} #{path}"
    request_class_pb, response_class_pb = PB_TABLE[route]
    req = nil
    case method
    when :get
      req = Net::HTTP::Get.new(path)
    when :post
      req = Net::HTTP::Post.new(path)
    when :put
      req = Net::HTTP::Put.new(path)
    when :delete
      req = Net::HTTP::Delete.new(path)
    else
      raise "Unsupported HTTP method: #{method}"
    end

    if request_class_pb
      req['Content-Type'] = 'application/vnd.google.protobuf'
      req.body = request_class_pb.encode(request_class_pb.new(payload))
    end
    req['Accept'] = 'application/vnd.google.protobuf, text/plain'
    req['Cookie'] = @cookie.map {|k,v| "#{k}=#{v}"}.join('; ')

    res = Net::HTTP.start(@host, @port) do |http|
      http.request(req)
    end

    if res['Set-Cookie']
      cookie_key, cookie_value = res['Set-Cookie'].split(';')[0].split('=')
      @cookie[cookie_key] = cookie_value
    end

    case res['Content-Type']
    when /^application\/vnd\.google\.protobuf;?/
      @response = response_class_pb.decode(res.body).to_h
    else
      @response = res.body
    end
    @status = res.code
    @response
  end
end
