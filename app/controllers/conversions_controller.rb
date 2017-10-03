class ConversionsController < ApplicationController
  def home
    @exchanges = Exchange.all
  end
end
