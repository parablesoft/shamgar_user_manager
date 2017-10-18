ActiveRecord::Base.establish_connection(:adapter => "sqlite3", :database => ":memory:")

ActiveRecord::Schema.define(:version => 1) do
  create_table :users do |t|
    t.string :first_name
    t.string :last_name
    t.string :email
    t.string :role
    t.string :authentication_token
    t.datetime :deleted_at
    t.datetime :confirmed_at
  end
end



class User < ActiveRecord::Base
  include ShamgarUserManager::BaseUser
end
