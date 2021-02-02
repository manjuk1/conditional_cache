# ConditionalCache
Rails controller plugin to support conditional get in your app.

To know more about conditional get 
```ruby
https://guides.rubyonrails.org/caching_with_rails.html#conditional-get-support
```

Rails by default supports conditional get based on ActiveRecord Object or ActiveRecord relation. But, if your business logic pulls data across tables then there is no right way to achieve this *or* there could be a right way but I did not really try to look at it ;) . Neverthless, this was an opportunity for me to build my own rails plugin.

## Usage

*include ConditionalCache*

```ruby
class ApplicationController < ActionController::Base
  include ConditionalCache
  
  # override this method to support conditional caching at user level
  def conditional_get_key
    # return user or session specific identifier. Ex: auth_token or session id or user id
    # current_user.id
  end
end
```

*conditional_get :model_name1, :model_name2 .....*

```ruby
class UsersController < ApplicationController

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
```

## Installation
Add this line to your application's Gemfile:

```ruby
gem "conditional_cache", git: "https://github.com/manjuk1/conditional_cache.git"
```

And then execute:
```bash

$ bundle install
```
## Test Results
```ruby
Started GET "/users/index" for 127.0.0.1 at 2021-02-02 12:37:48 +0530
Processing by UsersController#index as HTML
  [1m[36mUser Load (0.2ms)[0m  [1m[34mSELECT  "users".* FROM "users" ORDER BY "users"."id" ASC LIMIT ?[0m  [["LIMIT", 1]]
  [1m[35m (0.3ms)[0m  [1m[34mSELECT MAX(updated_at) as last_updated_at from (SELECT updated_at from users UNION SELECT updated_at from addresses UNION SELECT updated_at from cities UNION SELECT updated_at from states) tabl[0m
  Rendering users/index.html.erb within layouts/application
  Rendered users/index.html.erb within layouts/application (1.6ms)
Completed 200 OK in 241ms (Views: 221.3ms | ActiveRecord: 0.5ms)
```
```ruby
Started GET "/users/index" for 127.0.0.1 at 2021-02-02 12:37:48 +0530
Processing by UsersController#index as HTML
  [1m[36mUser Load (0.2ms)[0m  [1m[34mSELECT  "users".* FROM "users" ORDER BY "users"."id" ASC LIMIT ?[0m  [["LIMIT", 1]]
  [1m[35m (0.3ms)[0m  [1m[34mSELECT MAX(updated_at) as last_updated_at from (SELECT updated_at from users UNION SELECT updated_at from addresses UNION SELECT updated_at from cities UNION SELECT updated_at from states) tabl[0m
Completed 304 Not Modified in 2ms (ActiveRecord: 0.5ms)
```
First hit, API took 241ms to respond. But second call took only 2ms. This is huge improvement in the performance. The test case is rendering a simple view. In reality, conditional get can make a big difference in your apps throughput and performance.

## Contributing
Please feel free to provide your suggestions or raise pull request if you would like to enhance.

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
