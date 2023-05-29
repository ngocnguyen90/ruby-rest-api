module AuthorizationHelper
  def login(user = nil)
    @user = user || current_user
    allow(Authentication::AuthorizeApiRequest).to receive_message_chain(:call, :result) { @user }
  end

  def current_user
    @current_user ||= create(:user)
  end
end

RSpec.configure do |c|
  c.include AuthorizationHelper, type: :request
end
