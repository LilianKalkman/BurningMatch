# zBurning Match

Select all students

```ruby
@students = User.all.where(admin: false)
```



Select from Matches with student1_id = 19, this works

```ruby
@student = 19
Match.where("student1_id = ?", @student).each do |row|
  print row.student1_id
  print "-"
  puts row.student2_id
end
```

Test :

```ruby
class User < ApplicationRecord
  scope :admin, -> { where admin: true }
  scope :student, -> { where admin: false }
end
User.student
```

**! This works !** : 

```ruby
Match.where(student1_id: 22).or(Match.where(student2_id: 22))
```

or: 

```ruby
Match.where('(student1_id = ?) OR (student2_id = ?)', 23, 23)
```





Select from Matches with @student, **does not work**

```ruby
# @student defined
@this_student_matches = Match.all.where(student1: #{@student} or student2: #{@student})
```



Select from Matches with @student where student1 = xx  OR student2 = xx, **does not work**

```ruby
@student = 19
@student_matches = Match.where{(student1_id == @student || student2_id == @student)}

```

Also rather handy :

```shell
$ git remote -v
```



Other Tidbits

Under the hood with Devise:

```shell
$ export BUNDLER_EDITOR='atom'
$ bundle open devise
```



create date :  1.days.from_now, -1.days.from_now

truncate to date only : datetime.to_date



```




```