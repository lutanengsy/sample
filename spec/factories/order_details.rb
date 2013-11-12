# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :order_detail do
    association :order,   :factory => :order
    association :product, :factory => :product
    quantity 1
    unit "boxes"
    unit_price 10.00
  end

  factory :order_detail_only, class: OrderDetail do
    association :order,   :factory => :order
    quantity 1
    unit "boxes"
    unit_price 10.00
  end
 
end
