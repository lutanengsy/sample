# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :inventory do
    doc_no "DR123"
    product_id 1
    qty_in 1
    qty_out 0
  end
end
