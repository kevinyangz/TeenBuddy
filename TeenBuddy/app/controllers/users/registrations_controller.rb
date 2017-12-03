class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]

  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  def new
    build_resource({})
    resource.build_teenager
    resource.build_client
    yield resource if block_given?
    respond_with resource
  end

  # POST /resource
  # def create
  #   super
  # end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end


  protected

  # If you have extra params to permit, append them to the sanitizer.
   def configure_sign_up_params
     devise_parameter_sanitizer.permit(:sign_up, keys: [:role,
                                                        :teenager_attributes=> [:fname,:lname, :birth_date, ],
                                                        :client_attributes => [:fname, :lname]])
   end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
   def after_sign_up_path_for(resource)
       if resource.teenager
         edit_teenager_path(resource.teenager)
       elsif resource.client
         edit_client_path(resource.client)
       else
         super
       end

   end

   def inactive

   end

  # The path used after sign up for inactive accounts.
   def after_inactive_sign_up_path_for(resource)
     users_inactive_path
   end
end
