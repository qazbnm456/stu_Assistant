class SessionsController < Devise::SessionsController
  def new
    self.resource = resource_class.new(params.permit(:email, :password))
    clean_up_passwords(resource)
    respond_with(resource, serialize_options(resource))
  end
end