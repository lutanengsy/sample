# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :delivery do
    delivery_no "DR 001"
    delivery_date Date.today
  end

  factory :invalid_delivery, :class => 'Delivery' do
    delivery_no nil
  end 
end
