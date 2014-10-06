json.array!(@robots) do |robot|
  json.extract! robot, :id, :code_name_id
  json.url robot_url(robot, format: :json)
end
