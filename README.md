# shamgar\_user\_manager

Provides common user and user management application logic.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'shamgar_user_manager'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install shamgar_user_manager

## Usage


###Model

```ruby
include ShamgarUserManager::BaseUser
```

###Controller

```ruby
include ShamgarUserManager::UserManagerController
```

###Resource
```ruby
class Api::V1::UserResource < ShamgarUserManager::BaseResource
end
```

###Routes
```ruby
user_manager_for(resource_name,resource_method)
```

* ```resource_name``` - e.g :users
* ```resource_method``` - e.g resource or jsonapi-resources

###Generator

```
rails g shamgar_user_manager:resource resource_name_and_path
```
* ```resource_name_and_path``` - e.g: Api::V1::User


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

