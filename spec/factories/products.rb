# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :product do
    name "Something"
  end

  factory :invalid_product, class: Product do
   name nil
  end
end
