#!/bin/bash
#----------------------------- Reham 445003512 - Register students + validate student ID

students_file="students.txt"
bookings_file="bookings.txt"

# Ask user for a valid 9-digit student ID
get_valid_id() { 
  while true; do
    read -p "Enter student ID (9 digits): " id
    id="${id//[[:space:]]/}"  # remove spaces
    if [[ "$id" =~ ^[0-9]{9}$ ]]; then
      break 
    else
      echo "Invalid ID. It must be exactly 9 digits."
    fi
  done
}

# Add new student name and ID to the file
add_student() {
  read -p "Enter student name: " name
  get_valid_id
  echo "$id,$name" >> "$students_file"
  echo "Student registered successfully."
}

#----------------------------- Jouri 4450003702 - Make bookings + check room availability

# Book a room for a registered student
make_booking() {
  get_valid_id

  # Make sure student exists
  if ! grep -q "^$id," "$students_file"; then
    echo "Student ID not found. Please register first."
    return
  fi

  # Get room number between 1–10
  while true; do
    read -p "Enter room number (1-10): " room
    room="${room//[[:space:]]/}"
    if [[ "$room" =~ ^([1-9]|10)$ ]]; then
      break
    else
      echo "Invalid room number. Must be between 1 and 10."
    fi
  done

  # Get booking date and time
  read -p "Enter date (YYYY-MM-DD): " date
  read -p "Enter time (e.g. 14:00): " time

  # Check if room is already taken
  if awk -F',' -v r="$room" -v d="$date" -v t="$time" '$2 == r && $3 == d && $4 == t' "$bookings_file" | grep -q .; then
    echo "Sorry, this room is already booked at that time."
  else
    echo "$id,$room,$date,$time" >> "$bookings_file"
    echo "Room booked successfully."
  fi
}

#----------------------------- Toleen 445000362 - Search bookings + check room availability

# Let user search by ID or room
search_booking() {
  echo "Search by:"
  echo "1) Student ID"
  echo "2) Room number"
  read -p "Choose option: " opt

  case $opt in
    1)
      read -p "Enter student ID: " sid
      sid="${sid//[[:space:]]/}"
      awk -F',' -v id="$sid" '$1 == id' "$bookings_file"
      ;;
    2)
      read -p "Enter room number: " rnum
      rnum="${rnum//[[:space:]]/}"
      awk -F',' -v room="$rnum" '$2 == room' "$bookings_file"
      ;;
    *)
      echo "Invalid option."
      ;;
  esac
}

# Check if specific room is free at a certain time
check_room_availability() {
  read -p "Enter room number (1-10): " room
  room="${room//[[:space:]]/}"
  if ! [[ "$room" =~ ^([1-9]|10)$ ]]; then
    echo "Invalid room number. Must be between 1 and 10."
    return
  fi

  read -p "Enter date (YYYY-MM-DD): " date
  read -p "Enter time (e.g. 14:00): " time

  # Search if the room is booked
  if awk -F',' -v r="$room" -v d="$date" -v t="$time" '$2 == r && $3 == d && $4 == t' "$bookings_file" | grep -q .; then
    echo "Room $room is already booked on $date at $time."
  else
    echo "Room $room is available on $date at $time."
  fi
}

#----------------------------- Main Menu

# This menu repeats until the user chooses to exit
while true; do
  echo ""
  echo "----- Welcome to our Study Room Booking System -----"
  echo "1) Register new student"        # Option to add a new student with ID validation
  echo "2) Make a booking"             # Option to book a room for a registered student
  echo "3) Search booking"             # Option to search bookings by student ID or room number
  echo "4) Check room availability"   # New option to check if a room is free at a specific date and time
  echo "5) Exit"                     # Option to exit the program
  read -p "Choose an option: " choice

  case $choice in
    1) add_student ;;                # Call the function to register a new student
    2) make_booking ;;               # Call the function to make a booking
    3) search_booking ;;             # Call the function to search bookings
    4) check_room_availability ;;   # Call the function to check if a room is available
    5) echo "Goodbye!"; break ;;    # Exit the loop and end the program
    *) echo "Invalid option, please try again." ;;  # Handle invalid input
  esac
done

