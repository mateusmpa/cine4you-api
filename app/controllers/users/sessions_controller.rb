# frozen_string_literal: true

module Users
  class SessionsController < Devise::SessionsController
    # before_action :configure_sign_in_params, only: [:create]

    include RackSessionsFix

    respond_to :json

    # GET /resource/sign_in
    # def new
    #   super
    # end

    # POST /resource/sign_in
    # def create
    #   super
    # end

    # DELETE /resource/sign_out
    # def destroy
    #   super
    # end

    # protected

    # If you have extra params to permit, append them to the sanitizer.
    # def configure_sign_in_params
    #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
    # end

    private

    def respond_with(current_user, _opts = {})
      render json: {
        status: {
          code: 200, message: 'Logged in successfully.',
          data: { user: UserSerializer.new(current_user).serializable_hash[:data][:attributes] }
        }
      }, status: :ok
    end

    def respond_to_on_destroy
      current_user = find_current_user

      if current_user
        render_success_response
      else
        render_unauthorized_response
      end
    end

    def find_current_user
      return unless request.headers['Authorization'].present?

      jwt_payload = JWT.decode(request.headers['Authorization'].split.last,
                               Rails.application.credentials.devise_jwt_secret_key!).first
      User.find(jwt_payload['sub'])
    rescue StandardError
      nil
    end

    def render_success_response
      render json: { status: 200, message: 'Logged out successfully.' }, status: :ok
    end

    def render_unauthorized_response
      render json: { status: 401, message: "Couldn't find an active session." }, status: :unauthorized
    end
  end
end
