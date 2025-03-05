# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
[ {
  "title": "The Great Gatsby",
  "author": "F. Scott Fitzgerald",
  "genre": "Fiction",
  "isbn": "978-3-16-148410-0"
}, {
  "title": "The Catcher in the Rye",
  "author":
  "J.D. Salinger",
  "genre": "Fiction",
  "isbn": "978-3-16-148410-1"
}, {
  "title": "To Kill a Mockingbird",
  "author": "Harper Lee",
  "genre": "Fiction",
  "isbn": "978-3-16-148410-2"
}, {
  "title": "1984",
  "author": "George Orwell",
  "genre": "Fiction",
  "isbn": "978-3-16-148410-3"
}, {
  "title": "Animal Farm",
  "author": "George Orwell",
  "genre": "Fiction",
  "isbn": "978-3-16-148410-4"
}
].each do |book|
  Book.find_or_create_by!(book)
end
