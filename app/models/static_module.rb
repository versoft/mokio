# == Schema Information
#
# Table name: static_modules
#
#  id                   :integer          not null, primary key
#  available_modules_id :integer
#  title                :string(255)
#  content              :text
#  external_link        :string(255)
#  lang_id              :integer
#  active               :boolean          default(TRUE)
#  editable             :boolean          default(TRUE)
#  deletable            :boolean          default(TRUE)
#  always_displayed     :boolean
#  tpl                  :string(255)
#  display_from         :datetime
#  display_to           :datetime
#  created_at           :datetime
#  updated_at           :datetime
#  intro                :text
#

class StaticModule < ActiveRecord::Base
  include Mokio::Common::Model
  
  has_and_belongs_to_many :module_positions, :join_table => "available_modules"

  accepts_nested_attributes_for :module_positions

  validates :title, presence: true
  
  #
  # include module_positions to amoeba duplication process
  #
  amoeba do
    include_field :module_positions
  end

  def self.columns_for_table
    ["title", "active", "module_position_ids", "updated_at", "lang_id"]
  end

  def module_position_ids_view
    self.module_position_ids.map{|pos| ModulePosition.find(pos).name}.join(', ')
  end
end
