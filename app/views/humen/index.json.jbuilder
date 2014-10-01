json.array!(@humen) do |human|
  json.extract! human, :id, :name, :damage
  json.url human_url(human, format: :json)
end
