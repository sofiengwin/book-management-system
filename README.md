# Book Management API

## Overview

The Book Management API is a library system built using Ruby on Rails. It allows users to borrow and return books while keeping track of transactions, account balances The system ensures that users can only borrow books if they have sufficient balance.

## Features

1. **User Management**
  - Users have an account with an initial balance.
  - Users can query their account balance and borrowing history.
2. **Book Borrowing & Returning**
  - Users can borrow books if they have sufficient balance
  - A fee is deducted from the user's balance upon borrowing.
  - Users must return borrowed books before borrowing again.
3. **Reporting & Queries**
  - Query a user's account and borrowed books.
  - Query book loan counts
  - Generate user reports for monthly and annual borrowing activity.
  - Calculate book income over a time period.

## API Endpoints

### User Endpoints

- `POST /api/v1/users` - Create a new user with an initial balance.
- `GET /api/v1/users/:id/account` - Retrieve a user's account details.
- `GET /api/v1/users/:id/report?type=monthly|annual` - Get user borrowing report for a given period.

### Transaction Endpoints

- `POST /transactions/borrow` - Borrow a book (requires `user_id` and `book_id`).
- `POST /transactions/return` - Return a book (requires `user_id` and `book_id`).

### Book Endpoints
- `GET /books/:id/income?start_date=YYYY-MM-DD&end_date=YYYY-MM-DD` - Get total income for a book within a date range.

## Design Principles

### **1. Service-Oriented Architecture**

- Business logic is encapsulated in service objects (`BorrowBook`, `ReturnBook`, `BookIncome`).

### **2. Active Record Models**

- **User**: Manages user data and balance constraints.
- **Book**: Manages book details.
- **Transaction**: Tracks borrow and return transactions.

### **3. API Documentation with Swagger (Rswag)**

- Rswag is used to generate API documentation.
- Request examples are automatically included.

## Installation & Setup

1. Clone the repository:
   ```sh
   git clone https://github.com/your-repo/book-management-api.git
   cd book-management-api
   ```
2. Install dependencies:
   ```sh
   bundle install
   ```
3. Set up the database:
   ```sh
   rails db:create db:migrate db:seed
   ```
4. Run the server:
   ```sh
   rails s
   ```

## Running Tests

- Run RSpec tests:
  ```sh
  rspec
  ```
- Run API documentation tests:
  ```sh
  rake rswag:specs:swaggerize
  ```

## Future Improvements

- Book availability management.
- Implementing transaction status.
- Add background jobs for overdue book notifications.
- Improvements to authentication system

---

For more details, refer to the API documentation generated via Swagger UI.


