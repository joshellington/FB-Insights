require 'fbgraph'

def base_uri
  base_uri_raw = request.env["HTTP_HOST"]+request.env["SCRIPT_NAME"]
  path = URI.parse(request.env["REQUEST_URI"]).path
  base_uri = "http://"+base_uri_raw.split(path)[0]
end

def curr_path
  base_uri_raw = request.env["HTTP_REFERER"]
end

def match(path, opts={}, &block)
  get(path, opts, &block)
  post(path, opts, &block)
end

# Generates a random string from a set of easily readable characters
def generate_key(size = 6)
  charset = %w{ 2 3 4 6 7 9 A C D E F G H J K L M N P Q R T V W X Y Z}
  (0...size).map{ charset.to_a[rand(charset.size)] }.join
end