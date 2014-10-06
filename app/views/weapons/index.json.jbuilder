json.array!(@weapons) do |weapon|
  json.extract! weapon, :id, :name, :damage
  json.url weapon_url(weapon, format: :json)
end
