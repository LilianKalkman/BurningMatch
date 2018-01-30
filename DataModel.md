Add field *admin* boolean to users, generates a migration

```shell
$ rails generate migration AddAdminToUsers admin:boolean
```



Generate Match model

- to enable 2 attributes of the model Match to point to User, do the following :

```shell
$ rails generate model Match date:datetime student1:references student2:references
```

generates  migration :

```ruby
class CreateMatches < ActiveRecord::Migration[5.1]
  def change
    create_table :matches do |t|
      t.datetime :date
      t.references :student1, foreign_key: true
      t.references :student2, foreign_key: true

      t.timestamps
    end
  end
end
```

remove `, foreign_key: true`  , so change migration change into :

```ruby
class CreateMatches < ActiveRecord::Migration[5.1]
  def change
    create_table :matches do |t|
      t.datetime :date
      t.references :student1
      t.references :student2

      t.timestamps
    end
  end
end
```



app/models/user.rb, add , :class_name => "Match", :foreign_key => 'student1_id' and 'student2_id'

```ruby
class User < ActiveRecord::Base
  # Add next 2 lines
  has_many :student1_matches, :class_name => 'Match', :foreign_key => 'student1_id'
  has_many :student2_matches, :class_name => 'Match', :foreign_key => 'student2_id'
end
```



app/models/match.rb, add   `, :class_name => "User"`    (or    `, class_name: "User"` ?) after belongs_to's

```ruby
class Match < ApplicationRecord
  belongs_to :student1, :class_name => "User"
  belongs_to :student2, :class_name => "User"
end
```

dbseeds, check /db/seeds.rb

```ruby

```



Extra methods have been added to app/models/matches.rb, check matches.rb.

It is not totally finished, the part of choosing the last paired student is not done yet.



I added a app/views/pages/test.html.erb, check it out.

Much of the functionality should be ported to model Match



/config/routes.rb

```ruby
Rails.application.routes.draw do

  root to: "pages#home"
  devise_for :users

  # Add next line
  get "test" => "pages#test"

end

```









=========================================

From the net

ey Chris,

It's been a while since I did anything like this, but here's what I'd do:

```
rails new survey_app
cd survey_app
rails g model Survey title:string owner:references admin:references
rails g model User name:string
```

Next open up the `create_surveys.rb` migration file and make one small edit:

Change this:

```
class CreateSurveys < ActiveRecord::Migration[5.0]
  def change
    create_table :surveys do |t|
      t.string :title
      t.references :owner, foreign_key: true
      t.references :admin, foreign_key: true

      t.timestamps
    end
  end
end
```

To this:

```
class CreateSurveys < ActiveRecord::Migration[5.0]
  def change
    create_table :surveys do |t|
      t.string :title
      t.references :owner
      t.references :admin

      t.timestamps
    end
  end
end
```

We need to knock out `foreign_key: true` on both `:owner` and `:admin` as otherwise Rails will be looking for tables of these names

Then create and migrate the database:

```
rake db:create
rake db:migrate
```

Here you're creating the models and specifying that there are two columns in the Survey table that will be referred to as :owner and :admin and which hold references to another table.

Next edit the model files, thus:

```
class Survey < ApplicationRecord
  belongs_to :owner, :class_name => 'User'
  belongs_to :admin, :class_name => 'User'
end
```



```
class User < ApplicationRecord
  has_many :owned_surveys, :class_name => 'Survey', :foreign_key => 'owner_id'
  has_many :admin_surveys, :class_name => 'Survey', :foreign_key => 'admin_id'
end
```



Here you are creating a property on the Survey model named :owner, then specifying that this property is related to the `User` class. Rails, seeing the `belongs_to :owner`, will look for a column in the surveys table called "owner_id" and use that to store the foreign key. Then you're doing the exact same thing for the admin.

Then you are creating a property on the User Model named `:owned_surveys`, specifying that this property is related to the `Survey` model, and that the foreign key on the `Survey` model which relates it to this property is called 'owner_id'. Then you are doing the same thing for admin surveys.

I copied most of that explanation from [here25](http://stackoverflow.com/a/10260455/1136887).

And that's it. To test:

```
rails c
User.create(name: "Jim")
User.create(name: "Chris")
Survey.create(title: "How to baffle cats", owner_id: 1, admin_id: 2)

Survey.first().owner
=>  #<User id: 1, name: "Jim", created_at: "2017-02-20 13:23:40", updated_at: "2017-02-20 13:23:40">

Survey.first().admin
=> #<User id: 2, name: "Chris", created_at: "2017-02-20 13:23:46", updated_at: "2017-02-20 13:23:46">

User.first().owned_surveys
=> #<ActiveRecord::Associations::CollectionProxy [#<Survey id: 1, title: "How to baffle cats", owner_id: 1, admin_id: 2, created_at: "2017-02-20 13:23:49", updated_at: "2017-02-20 13:23:49">]>

User.find(2).admin_surveys
=> #<ActiveRecord::Associations::CollectionProxy [#<Survey id: 1, title: "How to baffle cats", owner_id: 1, admin_id: 2, created_at: "2017-02-20 13:23:49", updated_at: "2017-02-20 13:23:49">]>
```

Hope that helps some.



============================================



@students = User.all.where(admin: false)

============================================









<u>User</u>

- (id)
- email
- password



<u>Date</u>

- (id)
- date
- pairs_id



<u>Pairs</u>

- (id)



<u>PairedUsers</u>

- (id)
- pairs_id
- user_id



