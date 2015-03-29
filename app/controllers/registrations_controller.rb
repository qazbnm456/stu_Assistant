class RegistrationsController < Devise::RegistrationsController
  def new
    super
  end

  def create
    params[:user].merge! params[:user][:sex]
    params[:user].merge! params[:user][:major]
    params[:user].except!(:sex)
    params[:user].except!(:major)
    #above is optimization for sex and major

    #build_resource(sign_up_params)
    build_resource(params.require(:user).permit(:name, :sex_id, :major_id, :email, :time_zone, :password, :password_confirmation))

    if resource.save
      #resource.record << Record.create(cate: 'b1')
      #resource.record << Record.create(cate: 'b2')
      #resource.record << Record.create(cate: 'b3')
      #resource.record << Record.create(cate: 'b4')
      #resource.record << Record.create(cate: 'b5')
      #resource.record << Record.create(cate: 'w1')
      #resource.record << Record.create(cate: 'w2')
      #resource.record << Record.create(cate: 'w3')
      #resource.record << Record.create(cate: 'w4')
      #resource.record << Record.create(cate: 'w5')
      #resource.record << Record.create(cate: 'r1')
      #resource.record << Record.create(cate: 'r2')
      #resource.record << Record.create(cate: 'r3')
      #resource.record << Record.create(cate: 'r4')
      #resource.record << Record.create(cate: 'r5')
      #resource.record << Record.create(cate: 'c1')
      #resource.record << Record.create(cate: 'c2')
      #resource.record << Record.create(cate: 'c3')
      #resource.record << Record.create(cate: 'c4')
      #resource.record << Record.create(cate: 'c5')
      yield resource if block_given?
      if resource.active_for_authentication?
        set_flash_message :notice, :signed_up if is_flashing_format?
        sign_up(resource_name, resource)
        respond_with resource, location: show_user_path(resource)
      else
        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_flashing_format?
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      respond_with resource
    end
  end

  def update
    params[:user].merge! params[:user][:sex]
    params[:user].merge! params[:user][:major]
    params[:user].except!(:sex)
    params[:user].except!(:major)
    #above is optimization for
    self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)
    prev_unconfirmed_email = resource.unconfirmed_email if resource.respond_to?(:unconfirmed_email)

    resource_updated = update_resource(resource, params.require(:user).permit(:avatar, :name, :sex_id, :major_id, :email, :time_zone, :password, :password_confirmation, :current_password))
    yield resource if block_given?
    if resource_updated
      if is_flashing_format?
        flash_key = update_needs_confirmation?(resource, prev_unconfirmed_email) ?
            :update_needs_confirmation : :updated
        set_flash_message :notice, flash_key
      end
      sign_in resource_name, resource, bypass: true
      #respond_with resource, location: after_update_path_for(resource)
      respond_with resource, location: show_user_path(resource)
    else
      clean_up_passwords resource
      respond_with resource
    end
  end
end