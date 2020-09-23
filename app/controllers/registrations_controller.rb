class RegistrationsController < Devise::RegistrationsController
  before_action :set_photo_path, only: [:create]
  before_action :set_cover_image_path, only: [:create]

  def default_images_path(name)
    Rails.root.join('app/assets/images', name).to_s
  end

  def upload_photo(pic_to_upload, default_pic)
    auth = {
      cloud_name: Rails.application.credentials.cloud_name,
      api_key: Rails.application.credentials.api_key,
      api_secret: Rails.application.credentials.api_secret,
      enhance_image_tag: Rails.application.credentials.enhance_image_tag,
      static_file_support: Rails.application.credentials.static_file_support
    }
    pic = if params[:user][pic_to_upload].nil?
            default_images_path(default_pic)
          else
            params[:user][pic_to_upload].tempfile
          end
    upload = Cloudinary::Uploader.upload(pic, auth)
    upload
  end

  def get_image_path(pic_to_upload, default_pic)
    m_path = upload_photo(pic_to_upload, default_pic)
    return if m_path.nil?

    m_path['url']
  end

  def set_photo_path
    uploaded_pic = get_image_path('photo', 'default_user_photo.svg')
    params[:user][:photo] = uploaded_pic
  end

  def set_cover_image_path
    uploaded_pic = get_image_path('cover_image', 'default_cover.svg')
    params[:user][:cover_image] = uploaded_pic
  end

  private

  def sign_up_params
    params.require(:user).permit(:username,
                                 :full_name,
                                 :email,
                                 :photo,
                                 :cover_image,
                                 :password,
                                 :password_confirmation)
  end
end
