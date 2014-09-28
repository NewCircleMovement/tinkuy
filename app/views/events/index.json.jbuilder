json.array!(@events) do |event|
  json.extract! event, :id, :name, :description, :startdate, :starttime
  json.url event_url(event, format: :json)
end
