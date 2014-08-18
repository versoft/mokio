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
module Mokio
  class StaticModule < ActiveRecord::Base
    include Mokio::Concerns::Models::StaticModule
  end
end