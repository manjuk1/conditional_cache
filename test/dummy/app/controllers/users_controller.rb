class UsersController < ApplicationController
  include ConditionalCache

  def index
    # Usage:
    # conditional_get :model_name1, :model_name2 ......
    # Provide all the models from which data is extracted in the GET response.
    # Thought process:
    #     If there is no change in data in any of these tables, then there is no need to run
    #     through the complex business logic and render the response. This simple technique can
    #     significantly increase the throughput of your app server instance and also boost the
    #     performance of your app.
    conditional_get :User, :Address, :City, :State
    #your complex query and business logic goes here
  end
end
