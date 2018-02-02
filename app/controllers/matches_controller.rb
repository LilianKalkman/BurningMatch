class MatchesController < ApplicationController
  before_action :authenticate_user!

  def index
    if !current_user.admin?
      redirect_to mymatches_path, :alert => "Access denied"
    end
  end

  def match_stats
    if !current_user.admin?
      redirect_to mymatches_path, :alert => "Access denied"
    end
  end

  def my_matches
    if current_user.admin?
      redirect_to matches_path
    end
  end

  def make_matches
    if !current_user.admin?
      redirect_to(mymatches_path, :alert => "Access denied")
      return
    end

    date_par = params[:date]
    date     = date_par.to_date
    if !check_date_format(date_par, date)
      redirect_to matches_path, :alert => "Invalid date format"
    elsif !check_date_range(date)
      redirect_to matches_path, :alert => "Invalid date"
    elsif date.sunday?
      redirect_to matches_path, :alert => "That's a Sunday, don't be cruel!"
    elsif Match.where(date: date).count > 0
      redirect_to matches_path, :alert => "Students already matched"
    else
      match = Match.new
      match.create_new_matches(date)
      redirect_to matches_path, :notice => "Matches created for " + date.to_s
    end
  end

  def remove_matches
    if !current_user.admin?
      redirect_to(mymatches_path, :alert => "Access denied")
      return
    end

    date_par = params[:date]
    date     = date_par.to_date
    if !check_date_format(date_par, date)
      redirect_to matches_path, :alert => "Invalid date format"
    elsif !check_date_range(date)
      redirect_to matches_path, :alert => "Invalid date"
    elsif Match.where(date: date).count == 0
      redirect_to matches_path, :alert => "Students not matched yet"
    else
      match = Match.new
      match.unmatch_matches(date)
      redirect_to matches_path, :notice => "Matches removed for " + date.to_s
    end
  end

  def check_date_format(date_par, date)
    if date.nil? || date.class != Date
      return false
    elsif date.to_s != date_par
      return false
    end
    return true # Should not be necessary, but had issues
  end

  def check_date_range(date)
    if date < Date.today || date > Date.today + 7
      return false
    end
    return true # Should not be necessary, but had issues
  end

end
