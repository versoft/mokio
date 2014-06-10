# == Schema Information
#
# Table name: gmaps
#
#  id                          :integer          not null, primary key
#  full_address                :string(255)
#  street_number               :string(255)
#  route                       :string(255)
#  locality                    :string(255)
#  postal_code                 :string(255)
#  country                     :string(255)
#  administrative_area_level_2 :string(255)
#  administrative_area_level_1 :string(255)
#  gtype                       :string(255)
#  lat                         :decimal(10, 6)
#  lng                         :decimal(10, 6)
#  zoom                        :integer          default(15)
#  created_at                  :datetime
#  updated_at                  :datetime
#

class Gmap < ActiveRecord::Base
  has_one :content
  accepts_nested_attributes_for :content, allow_destroy: true

  validates :full_address, :lat, :lng, presence: true

  def self.gmap_attributes
    [ 
      :id, :full_address, :street_number, :route, :locality, :postal_code, :country, 
      :administrative_area_level_2, :administrative_area_level_1, :gtype, :lat, :lng, :zoom
    ]
  end
end
