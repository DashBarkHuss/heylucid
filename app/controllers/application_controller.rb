class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include UsersHelper
  include TimeHelper
  include RealityChecksHelper

 


end
