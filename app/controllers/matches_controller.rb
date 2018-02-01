class MatchesController < ApplicationController
  before_action :authenticate_user!

  def index
    if !current_user.admin?
      redirect_to mymatches_path
    end
  end

  def match_stats
    if !current_user.admin?
      redirect_to mymatches_path
    end
  end

  def create_new_matches
    if !current_user.admin?
      redirect_to mymatches_path
    end
    date = params[:date].to_date
    if date.class = "Date" && !date.empty
      match = Match.new
      match.create_new_matches(date)
    end
    redirect_to matches_path
  end

  def unmatch_matches
    if !current_user.admin?
      redirect_to mymatches_path
    end
    date = params[:date].to_date
    if date.class = "Date" && !date.empty
      match = Match.new
      match.unmatch_matches(date)
    end
    redirect_to matches_path
  end

  def my_matches
    if current_user.admin?
      redirect_to matches_path
    end
  end

end
