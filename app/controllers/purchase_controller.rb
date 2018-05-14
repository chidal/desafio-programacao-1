class PurchaseController < ApplicationController
  def index
    @last_purchases = Purchase.last(10)

    render "purchases/index"
  end

  def upload
    file_io = params[:document]

    # Process the document to generate the Purchases
    @fr = FileReader.execute(file_io)

    redirect_to root_path and return
  end

  def remove
    Purchase.find(params[:purchase_id]).destroy

    redirect_to root_path and return
  end

end
