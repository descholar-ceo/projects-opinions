class AddDefaultPicturesToTableUsers < ActiveRecord::Migration[6.0]
  def change
    change_column_default :users, :photo, from: :null, to: 'default_user_photo.svg'
    change_column_default :users, :cover_image, from: :null, to: 'default_cover.svg'
  end
end
