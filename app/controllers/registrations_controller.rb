class RegistrationsController < Devise::RegistrationsController
  before_action :upload_photo, only: [:create]

  def local_image_path(name)
    Rails.root.join('public/uploads', name).to_s
  end
  def upload_photo
    pic = params[:user]['photo'].tempfile
    upload = Cloudinary::Uploader.upload pic
    params[:user][:photo]=upload['url']
  end
  private
  def sign_up_params
    params.require(:user).permit(:username, :full_name, :email, :photo, :password, :password_confirmation)
  end

  def account_update_params
    params.require(:user).permit(:username, :full_name, :email, :photo, :password, :password_confirmation, :current_password)
  end
end
