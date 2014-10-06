json.array!(@code_names) do |code_name|
  json.extract! code_name, :id, :name, :info_reference
  json.url code_name_url(code_name, format: :json)
end
