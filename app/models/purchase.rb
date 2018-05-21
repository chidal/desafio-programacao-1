class Purchase < ApplicationRecord
  include ActiveModel::AttributeAssignment
  searchkick

  def search_data
    {
      address: self.merchant_address,
      purchaser_name: self.purchaser_name,
      merchant_name: self.merchant_name,
      count: self.purchase_count,
      description: self.item_description
    }
  end

  # TODO: Implementar bem o uso das models Dirty
end
