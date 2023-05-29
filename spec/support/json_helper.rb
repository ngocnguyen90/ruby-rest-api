module JsonHelper
  def response_body
    return nil if response.body.blank?

    JSON.parse(response.body, symbolize_names: true)
  end
end

RSpec.configure do |c|
  c.include JsonHelper, type: :request
end
