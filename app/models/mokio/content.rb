# == Schema Information
#
# Table name: contents
#
#  id           :integer          not null, primary key
#  title        :string(255)
#  subtitle :text
#  intro        :text
#  content      :text
#  type         :string(255)
#  home_page    :boolean
#  tpl          :string(255)
#  contact      :boolean
#  active       :boolean          default(TRUE)
#  lang_id      :integer
#  gallery_type :string(255)
#  editable     :boolean          default(TRUE)
#  deletable    :boolean          default(TRUE)
#  display_from :datetime
#  display_to   :datetime
#  created_at   :datetime
#  updated_at   :datetime
#  gmap_id      :integer
#
module Mokio
  class Content < ActiveRecord::Base
    include Mokio::Concerns::Models::Content
  end
end
