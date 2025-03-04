class Api::V1::ReportController < ApplicationController
  def user_report
    user = User.find(params[:id])
    type = params[:type]
    range = case type
    when "monthly" then 1.month.ago..Time.now
    when "annual" then 1.year.ago..Time.now
    else return render json: { error: "Invalid type" }, status: :unprocessable_entity
    end
    transactions = user.transactions.where(borrowed_at: range)
    total_spent = transactions.sum(:fee_charged)
    render json: { books_borrowed: transactions.count, total_spent: total_spent }
  end
end
