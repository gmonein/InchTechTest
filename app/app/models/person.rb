class Person < ApplicationRecord
  validates :reference, presence: true,
                        uniqueness: true
  validates :email, presence: true
  validates :home_phone_number, presence: true
  validates :mobile_phone_number, presence: true
  validates :firstname, presence: true
  validates :lastname, presence: true
  validates :address, presence: true

  include UnrepeatableAttributes
  set_unrepeatable_attributes %i[email home_phone_number mobile_phone_number address]
end
