json.array!(@events) do |event|
  json.extract! event, :id, :name, :description, :startdate, :starttime, :duration, :hour, :minute, :confirmed
  json.url event_url(event, format: :json)
end
