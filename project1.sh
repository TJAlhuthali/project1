#!/bin/bash
#---------------------------------------------------------- reham 445003512 Register students + validate student ID

students_file="students.txt"
bookings_file="bookings.txt"

get_valid_id() { 
}

add_student() {
}

#----------------------------------------------------------- jouri 4450003702 Make bookings + check if room is already booked

make_booking() {
}

#--------------------------------------------------------------- toleen 445000362 Search by student/room + room availability check

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

check_room_availability() {
 read -p "Enter room number (1-10): " room
  room="${room//[[:space:]]/}"
  if ! [[ "$room" =~ ^([1-9]|10)$ ]]; then
    echo "Invalid room number. Must be between 1 and 10."
    return
  fi

  read -p "Enter date (YYYY-MM-DD): " date
  read -p "Enter time (e.g. 14:00): " time

  if awk -F',' -v r="$room" -v d="$date" -v t="$time" '$2 == r && $3 == d && $4 == t' "$bookings_file" | grep -q .; then
    echo "Room $room is already booked on $date at $time."
  else
    echo "Room $room is available on $date at $time."
  fi
  }

#------------------------------------------------------------------------ Main Program

while true; do
  echo ""
  echo "----- Welcome to our Study Room Booking System -----"
  echo "1) Register new student"
  echo "2) Make a booking"
  echo "3) Search booking"
  echo "4) Exit"
  read -p "Choose an option: " choice

  case $choice in
    1) add_student ;;
    2) make_booking ;;
    3) search_booking ;;
    4) echo "Goodbye!"; break ;;
    *) echo "Invalid option, please try again." ;;
  esac
done


