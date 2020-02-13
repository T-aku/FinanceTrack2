class UserStocksController < ApplicationController
  
  def create
    stock = Stock.check_db(params[:ticker])
    if stock.blank?
      stock = Stock.new_lookup(params[:ticker])
      stock.save
    end
    @user_stock = UserStock.create(user: current_user, stock: stock)
    flash[:notice] = "Successfuly Added!!!"
    redirect_to my_portfolio_path
    
    # stock = Stock.new_lookup(params[:ticker])
    # if UserStock.find_by(user: current_user, stock: stock).blank?
    #   stock.save
    #   @user_stock = UserStock.new(user: current_user, stock: stock)
    #   @user_stock.save
    #   redirect_to my_portfolio_path
    # else
    #   flash[:error] = "You have already choosen that ticker!!"
    #   redirect_to my_portfolio_path
    # end
  end
  
  def destroy
    stock = Stock.find(params[:id])
    user_stock = UserStock.find_by(user_id: current_user.id, stock_id: stock.id)
    user_stock.destroy
    flash[:notice] = "Successfuly Removed!!"
    redirect_to my_portfolio_path
  end
  
end