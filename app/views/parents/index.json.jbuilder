json.array!(@parents) do |parent|
  json.extract! parent, :id, :name, :student_id, :email, :password_digest
  json.url parent_url(parent, format: :json)
end
