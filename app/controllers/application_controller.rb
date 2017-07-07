class ApplicationController < ActionController::Base
    # Prevent CSRF attacks by raising an exception.
    # For APIs, you may want to use :null_session instead.
    protect_from_forgery with: :exception

    before_action :configure_permitted_parameters, if: :devise_controller?

    protected

	    def configure_permitted_parameters
	      registration_params = [:email, :password, :password_confirmation, :username, :firstname, :lastname, :college, :gender, :remember_me]

	      if params[:action] == 'update'
	        devise_parameter_sanitizer.for(:account_update) { 
	          |u| u.permit(registration_params << :current_password)
	        }
	      elsif params[:action] == 'create'
	        devise_parameter_sanitizer.for(:sign_up) { 
	          |u| u.permit(registration_params) 
	        }
	        devise_parameter_sanitizer.for(:sign_in) { 
	          |u| u.permit(registration_params) 
	        }
	      end
	    end

	    def after_sign_in_path_for(resource)
			sign_in_url = new_user_session_url
			if request.referer == sign_in_url
			  '/home'
			else
			  stored_location_for(resource) || request.referer || root_path
			end
		end

		def authenticate_user!(*resource)
			if user_signed_in?
			  if controller_name == 'main' and action_name == 'admin_users' and current_user.email != ENV['ADMIN_EMAIL']
				redirect_to '/home'
			  end
			  super
			else
			  redirect_to new_user_session_path, :notice => 'You have not logged in'
			  ## if you want render 404 page
			  ## render :file => File.join(Rails.root, 'public/404'), :formats => [:html], :status => 404, :layout => false
			end
		end

		def sign_in_redirect_hack
			if controller_name == 'sessions' and action_name == 'new' and not current_user.nil?
				redirect_to '/home'
			elsif controller_name == 'registrations' and action_name == ('new' || 'cancel') and not current_user.nil?
				redirect_to '/home'
			elsif controller_name == 'passwords' and action_name == ('new' || 'edit') and not current_user.nil?
				redirect_to '/home'
			end
		end

end
