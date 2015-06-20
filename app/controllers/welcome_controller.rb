class WelcomeController < ApplicationController
  def index
    @cars = Car.all
  end
end
