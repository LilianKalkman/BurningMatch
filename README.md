Oscar :

The seed.rb has little adaptations from original repository, creating the data is done through the model Match.

Check DataModel.md in this repository for information about the changes I made.



# zBurning Match

Select all students

```ruby
@students = User.all.where(admin: false)
```

Select from Matches with @student

```ruby
# @student defined
@this_student_matches = Match.all.where(student1: #{@student} or student2: #{@student})
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