class Match < ApplicationRecord
  belongs_to :student1, :class_name => "User"
  belongs_to :student2, :class_name => "User"

  def create_match(match_date, student1, student2)
    Match.create!(date: match_date, student1_id: student1, student2_id: student2)
  end

  def get_student1(students)
    # Randomly choose from unmatched students
    students.sample
  end

  def get_student2(students, student1)
    # Choose student with whom student1 is least matched (TODO),
    #  for now, choose random other student
    studentsleft = students
    studentsleft.delete(student1)
    studentsleft.sample
  end

  def create_mymatches(match_date)
    @students = User.all.where(admin: false)
    @students_todo = []
    @students.each do |student|
      @students_todo.push(student.id)
    end

    while @students_todo.length > 1
      student1 = get_student1(@students_todo)
      student2 = get_student2(@students_todo, student1)

      create_match(match_date, student1, student2)

      @students_todo.delete(student1)
      @students_todo.delete(student2)
    end
  end

end
