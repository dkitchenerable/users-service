VCR.configure do |c|
  c.ignore_request do |request|
    URI(request.uri).port == 8981
  end  
  c.cassette_library_dir = 'spec/vcr'
  c.hook_into :webmock
end
