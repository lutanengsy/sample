# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :customer do
    name "John Doe"
    address "1 Golden Lane"
    zip 1234
    contact_no 12345678
  end

  factory :invalid_customer, :class => Customer do
    name nil
  end
end
