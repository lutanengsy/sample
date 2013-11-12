class Customer < ActiveRecord::Base
  attr_accessible :name, :address, :city, :state, :zip, :contact_no, :contact_person, :terms

  has_many :orders, :dependent => :restrict

  validates :name, :presence => true, :uniqueness => true
  validates :zip, :contact_no, :numericality => true, :allow_blank => true

  def to_s
    name
  end
end
