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
}

check_room_availability() {
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


