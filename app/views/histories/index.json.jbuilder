json.array!(@histories) do |history|
  json.extract! history, :id, :book_id, :member_email, :action
  json.url history_url(history, format: :json)
end
