class RankeyController < ApplicationController
  
  def show
    @user = User.first
  end
  
end