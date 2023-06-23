#!/bin/bash

students_file="students-list_0333.txt"

# Function to create a student record
create_student() {
    echo "Enter student email:"
    read email
    
    echo "Enter student age:"
    read age
    
    echo "Enter student ID:"
    read student_id
    
    # Append the student record to the file
    echo "$email|$age|$student_id" >> "$students_file"
    
    echo "Student record created successfully."
}

# Function to view all students
view_students() {
    if [[ ! -f "$students_file" ]]; then
        echo "No students found."
        return
    fi
    
    echo "List of students:"
    cat "$students_file"
}

# Function to delete a student by ID
delete_student() {
    echo "Enter student ID to delete:"
    read student_id
    
    # Create a temporary file for storing updated records
    temp_file="temp.txt"
    
    # Remove the student record from the file
    grep -v "^.*|$student_id$" "$students_file" > "$temp_file"
    
    # Replace the original file with the temporary file
    mv "$temp_file" "$students_file"
    
    echo "Student with ID $student_id deleted successfully."
}

# Function to update a student record by ID
update_student() {
    echo "Enter student ID to update:"
    read student_id
    
    # Create a temporary file for storing updated records
    temp_file="temp.txt"
    
    # Search for the student record in the file
    grep "^.*|$student_id$" "$students_file" > "$temp_file"
    
    if [[ ! -s "$temp_file" ]]; then
        echo "Student with ID $student_id not found."
        rm "$temp_file"
        return
    fi
    
    # Extract the student details from the temporary file
    old_record=$(cat "$temp_file")
    IFS='|' read -ra old_fields <<< "$old_record"
    
    echo "Enter new email (currently ${old_fields[0]}):"
    read new_email
    
    echo "Enter new age (currently ${old_fields[1]}):"
    read new_age
    
    # Create a new student record with updated fields
    new_record="$new_email|$new_age|$student_id"
    
    # Replace the old student record with the updated record
    sed -i "s~$old_record~$new_record~g" "$students_file"
    
    echo "Student with ID $student_id updated successfully."
    
    # Remove the temporary file
    rm "$temp_file"
}

# Main menu loop
while true; do
    echo "
    Bachelor of Software Engineering Cohort List
    
    1. Create student record
    2. View all students
    3. Delete student
    4. Update student record
    5. Exit
    
    Enter your choice:"
    
    read choice
    
    case $choice in
        1)
            create_student
            ;;
        2)
            view_students
            ;;
        3)
            delete_student
            ;;
        4)
            update_student
            ;;
        5)
            echo "Exiting application."
            exit 0
            ;;
        *)
            echo "Invalid choice. Please try again."
            ;;
    esac
done

