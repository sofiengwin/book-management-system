class Api::V1::ReportController < ApplicationController
  def user_report
    user = User.find(params[:id])
    transactions = user.transactions.where(borrowed_at: report_range)
    total_spent = transactions.sum(:fee_charged)
    render json: { books_borrowed: transactions.count, total_spent: total_spent }
  end

  private

  def report_range
    if params[:report_type] == "monthly"
      1.month.ago..Time.now
    else
      1.year.ago..Time.now # use annual as default
    end
  end
end
