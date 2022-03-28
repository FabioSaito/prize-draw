class Api::V1::DrawsController < Api::BaseController
  include ActionController::HttpAuthentication::Token::ControllerMethods
  before_action :authenticate, except: [ :index ]

  def index
    winners = Person.winners
    
    render json: winners, each_serializer: DrawSerializer , status: :ok
  end

  def create
    winner = DrawRandomSample.call()

    render json: winner, serializer: DrawSerializer, status: :ok
  end

  private

  def authenticate
    authenticate_or_request_with_http_token do |token, options|
      ActiveSupport::SecurityUtils.secure_compare(token, 'SecurePassword321')
    end
  end
end
