class WelcomeController < ApplicationController
  def index
    @testvar = "Hello World"
  end
  def hello(message)
  puts message
  end  
end
