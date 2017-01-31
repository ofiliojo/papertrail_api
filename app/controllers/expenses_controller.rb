class ExpensesController < ApplicationController
  before_action :set_expense, only: [:show, :update, :destroy]
  before_action :validate_user, only: [:create, :update, :destroy]
  before_action :validate_type, only: [:create, :update]

  def index
    if @current_user.admin
      expenses = Expense.all
    else
      expenses = @current_user.expenses
    end
    if params[:filter]
      expenses = expenses.where(["created_at < ?", params[:filter]])
    end
    expenses = expenses.page(params[:page] ? params[:page][:number] : 1)
    render json: expenses, meta: pagination_meta(expenses).merge(default_meta), include: ['user']
  end

  def show
    if @current_user.id == @expense.user_id
      render json: @expense, meta: default_meta
    else
      head 403
    end
  end

  def create
    expense = Expense.new(expense_params)
    if @current_user.id == expense.user_id
      if expense.save
        render json: expense, status: :created, meta: default_meta
      else
        render_error(expense, :unprocessable_entity)
      end
    else
      head 403
    end
  end

  def update
    if @current_user.id == @expense.user_id
      if @expense.update_attributes(expense_params)
        render json: @expense, status: :ok, meta: default_meta
      else
        render_error(@expense, :unprocessable_entity)
      end
    else
      head 403
    end
  end

  def destroy
    if @current_user.id == @expense.user_id
      @expense.destroy
      head 204
    else
      head 403
    end

  end

  private
  def set_expense
    begin
      @expense = Expense.find params[:id]
    rescue ActiveRecord::RecordNotFound
      expense = Expense.new
      expense.errors.add(:id, "Wrong ID provided")
      render_error(expense, 404) and return
    end
  end




  def expense_params
    ActiveModelSerializers::Deserialization.jsonapi_parse(params)
  end

 def pagination_meta(object)
   {
     current_page: object.current_page,
     next_page: object.next_page,
     prev_page: object.previous_page,
     total_pages: object.total_pages,
     total_count: object.total_entries
   }
 end
end
