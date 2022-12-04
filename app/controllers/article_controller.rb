class ArticleController < ApplicationController
  before_action :check_session, only: [:search]

  def index
    @articles = Article.all.first(50)
  end

  def search
    articles = Article.where('lower(title) LIKE ?', "%#{params[:query].downcase}%").first(60)
    render(partial: 'articles', locals: { articles: articles })
    save_search(params[:query], session[:user_id])
  end

  private

  def save_search(query, session)
    return if query.nil? || query.length < 3

    recent_search = Search.new(user_params)
    recent_search.session_id = session
    session_search = Search.where(session_id: session).last

  if session_search.query.length < query.length
    session_search.update(query: query)
    
   elsif session_search.nil? || !session_search.searched?(query)
    recent_search.save

   end
  end

  def user_params
    params.permit(:query)
  end

  def check_session
    session[:user_id] = SecureRandom.urlsafe_base64(16) if session[:user_id].nil?
  end
end
