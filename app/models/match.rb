class Match < ApplicationRecord
  belongs_to :student1, :class_name => "User"
  belongs_to :student2, :class_name => "User"

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
    students = get_students()

    show_matched = ""
    matches = get_matches(date)
    matches.each do |match|
      students.delete(match.student1_id)
      students.delete(match.student2_id)
      this_student1 = match.student1.name
      this_student2 = match.student2.name
      show_matched  = show_matched + "[" + this_student1 + " - " + this_student2 + "], "
    end

    if matches.count > 0 &&
        students.length > 0
      # TODO: Remove comments before Arno sees them :-)
      # Matches were found, unmatched students found
      # Also show unmatched students
      students.each do |id|
        student = User.find(id)
        show_matched = show_matched +
          "[Unmatched: " + student.name + "], "
      end
    end

    # Remove last space/comma
    show_matched[0...-2]
  end

  def create_matches(match_date)
    # TODO: Refactor so database is not queried for every student.
    @students = get_students
    while @students.length > 1
      student1 = get_student(@students)
      @students.delete(student1)

      if ENV["USER"] == "xzjan"
        # TODO: Fix it!
        student2 = get_match_for(student1, students)
      else
        student2 = get_student(@students)
      end
      @students.delete(student2)

      # Match.create!( etc ) was giving me issues
      match = Match.new(date: match_date, student1_id: student1, student2_id: student2)
      match.save
    end

    # TODO?: If @students_todo.length > 0, a student is unmatched
  end

  def get_student(candidates)
    # Randomly choose from unmatched students,
    #  .sample seems to favor certain outcomes
    student = rand(0..candidates.length)
    candidates[student]
  end

  def get_match_for(student, students = [])
    # Choose from least matched with
    # TODO: Refactor so database is not queried for every student.

    # Get match count with other students in ascending order
    matches    = get_matched_with(student)
    candidates = []
    count      = -1
    if matches.length == 0
      # No matches found for this studen,
      #   set candidates to given list of id's
      candidates = students
    else
      matches.each do | s , c |
        if students.include?(s)
          if count == -1
            count = c
          end
          if c = count
            candidates.push(s)
          end
        end
      end
    end
    student2 = get_student(candidates)
  end

  def get_matched_with(student)
    # Return hash of student_id's and times matched,
    #   with times ascending order
    # TODO: Refactor so database is not queried for every student.
    matches = Hash.new
    matched = Match.where(student1_id: student).or(Match.where(student2_id: student))
    matched.each do |match|
      if match.student1_id == student
        other_student = match.student2_id
      else
        other_student = match.student1_id
      end
      if matches.has_key?(other_student)
        matches[other_student] += 1
      else
        matches[other_student] = 1
      end
    end
    # Sort in ascending order on times matched
    return matches.sort_by { | student, count | count }
  end

end
