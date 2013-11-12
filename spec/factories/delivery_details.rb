# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :delivery_detail do
    quantity 1
    association :product, :factory => :product
    association :delivery,:factory => :delivery
    price "9.99"
    unit "boxes"
  end
end
