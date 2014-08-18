# == Schema Information
#
# Table name: menus
#
#  id               :integer          not null, primary key
#  name             :string(255)
#  active           :boolean          default(TRUE)
#  seq              :integer
#  target           :string(255)
#  external_link    :string(255)
#  lang_id          :integer
#  editable         :boolean          default(TRUE)
#  deletable        :boolean          default(TRUE)
#  visible          :boolean          default(TRUE)
#  position_id      :integer
#  ancestry         :string(255)
#  created_at       :datetime
#  updated_at       :datetime
#  description      :string(255)
#  content_editable :boolean          default(TRUE)
#  modules_editable :boolean          default(TRUE)
#  fake             :boolean          default(FALSE)
#  meta_id          :integer
#  slug             :string(255)
#
module Mokio
  class Menu < ActiveRecord::Base
    include Mokio::Concerns::Models::Menu
  end
end
