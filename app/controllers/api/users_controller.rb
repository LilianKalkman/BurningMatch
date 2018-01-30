class Api::UsersController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_
  
  def update

    render status: 200, json: {
      rooms: Room.all
    }.to_json
  end

end
