class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy
  has_many :transactions
  has_many :books, through: :transactions

  normalizes :email_address, with: ->(e) { e.strip.downcase }

  validates :name, presence: true, on: :create
  validates :email_address, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }
  validates :balance, numericality: { greater_than_or_equal_to: 0 }
  validates :password, length: { minimum: 6 }, on: :create

  def can_borrow_book?(fee_charged:)
    balance - fee_charged > 0
  end
end
