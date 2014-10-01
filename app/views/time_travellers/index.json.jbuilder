json.array!(@time_travellers) do |time_traveller|
  json.extract! time_traveller, :id, :name, :damage
  json.url time_traveller_url(time_traveller, format: :json)
end
