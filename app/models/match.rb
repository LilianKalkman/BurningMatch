class Match < ApplicationRecord
  # Connect student id's to User class
  belongs_to :student1, :class_name => "User"
  belongs_to :student2, :class_name => "User"

  def create_new_matches(date)
    create_matches(date)
  end

  def unmatch_matches(date)
    destroy_matches(date)
  end

  def get_matches(date)
    Match.where(date: date)
  end

  def get_students
    students = User.where(admin: false)
    student_ids = []
    students.each do |student|
      student_ids.push(student.id)
    end
    return student_ids
  end

  def show_matched_students(date)
    @students    = get_students()
    show_matched = ""

    matches = get_matches(date)
    matches.each do |match|
      this_student1 = match.student1.name
      this_student2 = match.student2.name
      show_matched += "[" + this_student1 + " - " + this_student2 + "], "

      @students.delete(match.student1_id)
      @students.delete(match.student2_id)
    end

    if matches.count > 0 && @students.length > 0
      # TODO: Remove comments before Arno sees them :-)

      # Matches found and unmatched students remaining
      # Add unmatched students to result
      @students.each do |id|
        student = User.find(id)
        show_matched += "[" + student.name + " - Unmatched!], "
      end
    end

    # Remove last comma/space
    return show_matched[0...-2]
  end

  def destroy_matches(date)
    match = Match.where(date: date)
    match.destroy_all
  end

  def create_matches(match_date)
    # TODO: Refactor so database is not queried for every student.
    @students = get_students
    while @students.length > 1
      student1 = get_student(@students)
      @students.delete(student1)

      student2 = get_match_for(student1, @students)
      @students.delete(student2)

      # Match.create!( etc ) was giving me issues
      match = Match.new(date: match_date, student1_id: student1, student2_id: student2)
      match.save
    end

    # TODO?: If @students_todo.length > 0, a student is unmatched
  end

  def get_student(students)
    # Randomly choose from unmatched students,
    #  .sample seems to favor certain outcomes
    student = rand(0..students.length-1)
    return students[student]
  end

  def get_match_for(student, students = [])
    # Choose from least matched with

    # Get match count with other students in ascending order
    matches = get_matched_with(student, students)
    matches.each do | student , count |
      if students.include?(student)
        # Student found in given student id's, choose
        return student
      end
    end
    # No matches found for student, choose from student id's
    return get_student(students)
  end

  def get_matched_with(student, students, descending = false)
    # TODO: Refactor so database is not queried for every student.
    # Return hash of student_id's and times matched

    # Initiate hash with given student id's
    @matches = Hash.new
    students.each do | student |
       @matches[student] = 0
    end

    # Get previous matches for this student
    matched = Match.where(student1_id: student).or(Match.where(student2_id: student))
    matched.each do |match|
      upd_matched_with(student, match.student1_id, match.student2_id)
    end

    # Sort on times matched
    if descending
      return @matches.sort_by { | student, count | -count }
    else
      return @matches.sort_by { | student, count | count }
    end
  end

  def upd_matched_with(student, student1, student2)
    other_student = student1 == student ? student2 : student1
    # Update total, create if it does not exist yet (promoted to Admin?)
    if @matches.has_key?(other_student)
      @matches[other_student] += 1
    else
      @matches[other_student] = 1
    end
  end

end
