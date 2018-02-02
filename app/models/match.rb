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

  def get_match_stats(format = "html")
    compile_match_stats(format)
  end

  def get_students(order = "")
    User.where(admin: false).order(order).ids
  end

  def get_user_names
    # Store user names in hash to reduce database queries
    names = {}
    User.all.each do | user |
      names[user.id] = user.name
    end
    return names
  end

  def show_matched_students(date)
    user_names  = get_user_names
    students    = get_students()
    show_matched = ""

    matches = get_matches(date)
    matches.each do |match|
      this_student1 = user_names[match.student1_id]
      this_student2 = user_names[match.student2_id]

      show_matched += "[" + this_student1 + " - " + this_student2 + "], "

      students.delete(match.student1_id)
      students.delete(match.student2_id)
    end

    if matches.count > 0 && students.length > 0
      # Matches found and unmatched students remaining
      # Add unmatched students to result
      students.each do |id|
        show_matched += "[" + user_names[id] + " - Unmatched!], "
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

  def get_match_for(student, students)
    # Choose from students least matched with

    # Get match count with other students in ascending order
    matches = get_matched_with(student, students)
    matches.each do | student , count |
      if students.include?(student)
        # Student found in given student id's, choose
        return student
      end
    end
    # No matches found for student, choose from students
    return get_student(students)
  end

  def get_matched_with(student, students, descending = false)
    # TODO: Refactor so database is not queried for every student.
    # Return hash of student_id's and times matched

    # Initiate hash with given student id's
    @matches = Hash.new
    students.each do | stud |
       @matches[stud] = 0
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
    # Update total
    other_student = student1 == student ? student2 : student1
    if @matches.has_key?(other_student)
      @matches[other_student] += 1
    end
  end

  def compile_match_stats(format = "html")
    @stats_hash = {}
    @stats_names = {}
    @match_stats_format = ""
    init_match_stats
    generate_match_stats
    match_stats_to_format(format)
  end

  def init_match_stats
    students        = User.where(admin: false).order(:email)
    students_x_axis = Hash.new
    students.each do |student|
      students_x_axis[student.id] = 0
    end
    students.each do |student|
      # .to_a.to_h :
      # Dereferencing object to make it 'stand alone', otherwise changing
      #   value in 1 nested hash would also change value in other nested hash
      @stats_hash[student.id]  = students_x_axis.to_a.to_h
      @stats_names[student.id] = student.name
    end
  end

  def generate_match_stats
    all_matches = Match.all
    all_matches.each do |match|
      # Take 'student turned into admin' into account
      if @stats_hash.has_key?(match.student1_id) &&
          @stats_hash.has_key?(match.student2_id)
        @stats_hash[match.student1_id][match.student2_id] += 1
        @stats_hash[match.student2_id][match.student1_id] += 1
      end
    end
  end

  def match_stats_to_format(format = "html")
    if format == "html"
      @html = ""
      init_match_stat_head_html
      render_match_stats_html
      return @html
    elsif format == "hash"
      return @stats_hash
    elsif format == "json"
      return @stats_hash.to_json
    else
      return ""
    end
  end

  def init_match_stat_head_html
    @html += "<thead>\n<tr>"
    @html += "\n<td>Student</td>"
    @stats_hash.each_key { | student_id |
      @html += "<td>" + @stats_names[student_id] + "</td>"
    }
    @html += "\n</tr>\n</thead>"
  end

  def render_match_stats_html
    @html += "\n<tbody>"
    @stats_hash.each { | student_id, student_matches |
      @html += "\n<tr>\n"
      @html += "<td>" + @stats_names[student_id] + "</td>"
      @this_id = student_id
      student_matches.each { | key, times |
        if key == @this_id
          @html += "<td>-</td>"
        else
          @html += "<td>" + times.to_s + "</td>"
        end
      }
      @html += "\n</tr>"
    }
    @html += "\n</tbody>"
  end

end
