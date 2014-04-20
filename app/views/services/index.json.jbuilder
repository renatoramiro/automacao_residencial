json.array!(@services) do |service|
  json.extract! service, :id, :title, :code, :description
  json.url service_url(service, format: :json)
end
