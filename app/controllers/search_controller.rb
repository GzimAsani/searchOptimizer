class SearchController < ApplicationController
   skip_before_action :verify_authenticity_token  
  def index
    @grouped_searches = Search.group(:query).pluck('query, count(query) as COUNT').sort_by do |a|
      a[1]
       
    end.reverse.first(100)
   
  end
end
