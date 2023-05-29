class Api::V1::UsersController < Api::V1Controller
  skip_before_action :authenticate_request, only: %i[register login]

  def register
    user = User.create(user_params)
    if user.save
      render json: { message: 'User was successfully created' }, status: 200
    else
      render json: user.errors, status: 400
    end
  end

  def login
    authorization = Authentication::AuthenticateUser.call(login_params[:email], login_params[:password])
    if authorization.successful?
      access_token, refresh_token, exp = authorization&.result&.result
      user_infor = Jwt::JwtService.decode(access_token)
      render(json: {
               user_id: user_infor['user_id'],
               email: user_infor['email'],
               access_token: access_token,
               refresh_token: refresh_token&.crypted_token,
               exp: exp
             })
    end
    raise(Error::InvalidCredentialError) unless authorization.successful?
  end

  def logout
    authorization = Jwt::Revoker.call(current_user, request.headers)
    render json: { message: 'User was successfully logged out' }, status: 200 if authorization.successful?
    raise(Error::InvalidTokenError) unless authorization.successful?
  end

  def refresh
    authorization = Authentication::RefreshTokenRequest.call(current_user, request.headers, params[:refresh_token])
    if authorization.successful?
      access_token, refresh_token, exp = authorization&.result&.[](0)&.result
      render(json: {
               access_token: access_token,
               refresh_token: refresh_token&.crypted_token,
               exp: exp
             })
    end
    raise(Error::InvalidCredentialError) unless authorization.successful?
  end

  private

  def user_params
    params.permit(:email, :password, :password_confirmation)
  end

  def login_params
    params.permit(:email, :password)
  end
end
