json.array!(@members) do |member|
  json.extract! member, :id, :name, :email, :password_digest
  json.url member_url(member, format: :json)
end
