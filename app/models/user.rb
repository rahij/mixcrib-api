class User < ActiveRecord::Base
  def authentic?
    password == params[:password]
  end
end
