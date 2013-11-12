# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :order do
    customer_id 1
    association :customer, :factory => :customer
    order_date Date.today
    total_amount 0
    amount_paid 0
  end

  factory :order_without_customer, :class => Order do
    customer_id 1
    order_date Date.today
    total_amount 0
    amount_paid 0
  end

  factory :invalid_order, :class => Order do
    customer_id nil
    order_date nil
    total_amount nil
  end
end
