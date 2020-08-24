class Building < ApplicationRecord
  validates :reference, presence: true,
                        uniqueness: true
  validates :address, presence: true
  validates :zip_code, presence: true
  validates :city, presence: true
  validates :country, presence: true
  validates :manager_name, presence: true

  include UnrepeatableAttributes
  set_unrepeatable_attributes %i[manager_name]
end
