class NewsController < ApplicationController
  def index
    @news = News.all(:parent_id => "#{params[:league_id]}/teams/#{params[:team_id]}")
    render :json => @news[0..4]
  end
end
