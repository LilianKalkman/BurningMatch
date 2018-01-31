class Match < ApplicationRecord
  belongs_to :student1, :class_name => "User"
  belongs_to :student2, :class_name => "User"

  def get_matches(date)
    Match.where(date: date)
  end

  def show_matched(date)
    show_matched = ""
    @matches = Match.all.where(date: date)
    @matches.each do |match|
      this_student1 = match.student1.email.partition("@")[0].capitalize
      this_student2 = match.student2.email.partition("@")[0].capitalize

      show_matched = show_matched + "[" + this_student1 + "<->" + this_student2 + "], "
    end
    return show_matched
  end

  def create_matches(match_date)
    @students      = User.where(admin: false)
    @students_todo = []
    @students.each do |student|
      @students_todo.push(student.id)
    end

    while @students_todo.length > 1
      student1 = get_student(@students_todo)
      @students_todo.delete(student1)

      # TODO: Separate method to choose student2 according to
      #   least times matched with student1
      student2 = get_student(@students_todo)
      @students_todo.delete(student2)

      # Match.create!( etc ) was giving me issues
      match = Match.new(date: match_date, student1_id: student1, student2_id: student2)
      match.save
    end

    # TODO?: If @students_todo.length > 0, a student is unmatched
  end

  def get_student(students)
    # Randomly choose from unmatched students,
    #  .sample seems to prefer certain outcomes
    student = rand(0..students.length)
    students[student]
  end

end
