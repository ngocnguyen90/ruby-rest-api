class Api::V1::ThemesController < Api::V1Controller
  before_action :user_theme, only: %i[update show]

  def show
    @theme ||= Theme.default_themes
    render json: @theme, status: 200 unless @theme.blank?
  end

  def update
    @result = @theme.blank? ? Theme.create(theme_params) : @theme.update(theme_params)

    if !!@result != @result && @result.errors.presence
      render json: @result.errors, status: 400
    elsif @result == false
      render json: @theme.errors, status: 400
    else
      render json: { message: 'Theme was successfully updated' }, status: 200
    end
  end

  private

  def user_theme
    @theme = Theme.find_by(user_id: current_user[:id])
  end

  def theme_params
    params.permit(:header_color, :logo, :avatar).merge(user_id: current_user[:id])
  end
end
