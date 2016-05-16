class SearchController < ApplicationController
  def results
    @search = TovgdbSearch.new(params)
  end
end
