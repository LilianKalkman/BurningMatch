class Match < ApplicationRecord
  belongs_to :student1, :class_name => "User"
  belongs_to :student2, :class_name => "User"

  def get_matches(date)
    Match.where(date: date)
  end

  def show_matched_students(date)
    # TODO: Refactor this block, used also in create_matches
    @students     = User.where(admin: false)
    @student_ids = []
    @students.each do |student|
      @student_ids.push(student.id)
    end

    show_matched = ""
    @matches = Match.where(date: date)
    @matches.each do |match|
      @student_ids.delete(match.student1_id)
      @student_ids.delete(match.student2_id)
      this_student1 = match.student1.email.partition("@")[0].capitalize
      this_student2 = match.student2.email.partition("@")[0].capitalize
      show_matched  = show_matched + "[" + this_student1 + " - " + this_student2 + "], "
    end
    # TODO: show unmatched students if any
    # if @student_ids.length > 0 do
    #   @student_ids.each do |id|
    #     student = User.find(id)
    #     show_matched = show_matched +
    #      "[Unmatched: " + student.email.partition("@")[0].capitalize + ", ]"
    #   end
    # end
    # Remove last space/comma
    show_matched[0...-2]
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
