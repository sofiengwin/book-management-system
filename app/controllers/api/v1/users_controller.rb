module Api
  module V1
    class UsersController < ApplicationController
      # allow_unauthenticated_access only: [ :create ]

      def create
        user = User.new(user_params)
        if user.save
          render json: { user_id: user.id, balance: user.balance }, status: :created
        else
          render json: { error: user.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def account
        user = User.find(params[:id])
        render json: { balance: user.balance, borrowed_books: user.books }
      end

      def report
        user = User.find(params[:id])
        transactions = user.transactions.where(borrowed_at: report_range)
        total_spent = transactions.sum(:fee_charged)
        render json: { books_borrowed: transactions.count, total_spent: total_spent }
      end

      private

      def user_params
        params.require(:user).permit(:name, :email_address, :password, :balance)
      end

      def report_range
        if params[:report_type] == "monthly"
          1.month.ago..Time.now
        else
          1.year.ago..Time.now # use annual as default
        end
      end
    end
  end
end
