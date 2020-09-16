json.extract! following, :id, :follower_id, :followed_id, :created_at, :updated_at
json.url following_url(following, format: :json)
